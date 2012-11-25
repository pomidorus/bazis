#encoding: utf-8

require "iconv"

module VP

  #----------------------------------------------
  class FileFactory

    def self.create(file)
      r = VP::FileR28.new(file) if check_ext?(file, "r28")
      r = VP::File004.new(file) if check_ext?(file, "004")
      r
    end

    def self.check_ext?(file, ext)
      e = file.original_filename[-3,3].downcase
      e == ext ? true : false
    end

  end

  #----------------------------------------------
  class VPFile
    attr_accessor :file, :file_name, :vipiska_name, :vpfile,
                  :acc1, :acc2, :plateg

    ACCOUNT_START = /ВИПИСКА по РАХУНКУ/u
    DATE_PATTERN = /([0-9][0-9])\\(.*?)\\([0-9][0-9])/
    VIPISKA_PAT = /(vp111.+?\.utf)/u

    RAHUNOK_START = /Рахунок:/u
    RAHUNOK_PATTERN = /\b[0-9]+\b/um
    PLATEG_START = /\b(?:A|R|B)..\b/um
    PLATEG_END = /^---/u
    SUMMA_PATT = /\s+(\b[0-9]+\.[0-9]+\b)/u
    BANK_PATT = /...\s+[0-9]{8}\s+([0-9]{6})/u
    FIZ_PATT = /^(\d{10})/u
    UR_PATT = /^(\d{8})/u
    FIZC_PATT = /;(\d{10})/u
    URC_PATT = /(\d{8})/u


    def initialize(f)
      @file = f
      @file_name = f.original_filename
      @vipiska_name = f.original_filename + ".utf"
      @acc1 = ""
      @acc2 = ""
    end

    def work_prepare
      @vpfile = VipiskaFile.create({:file_name => file_name, :upload_at => Date.today,
                                   :file_for_data => "2012-10-10", :file_size => get_file_size})
      create_dir
      File.open(@file_name, 'wb') {|f| f.write(@file.read)}
    end

    def create_dir(path="public/upload")
        directory = "#{Rails.root}/#{path}"
        Dir.chdir(directory)
        # Создаю директорию для файла
        new_file_dir = vpfile.id.to_s
        Dir.mkdir(new_file_dir, 0700)
        Dir.chdir(new_file_dir)
        Dir.mkdir("files", 0700)
    end

    def get_file_size
      fs = (file.tempfile.size/1024.0).round(1).to_s
      fs["."] = ","
      "#{fs} КБ"
    end

    def files_to_utf(path)
      pwd = Dir.pwd

      Dir.foreach(pwd + path) do |f|
        convert_utf(f,path) unless f == "." or f == ".." or f == "files"
      end

      Dir.foreach(pwd + path) do |f|
        if vipiska_name == ""
          r = VIPISKA_PAT.match(f)
          Rails.logger.debug "Bazis: #{r}" unless r.nil?
          @vipiska_name = r[0] unless r.nil?
        end
      end

      Rails.logger.debug "Bazis: #{vipiska_name}"
    end


    def convert_utf(f,path)

      vp004 = "." + path + "/" + f
      vp004_file = File.open(vp004, 'r')
      c = vp004_file.read()
      vp004_file.close()
      #
      conv = Iconv.new('UTF-8','CP1251')
      vp004_utf8 = conv.iconv(c)
      vp004_utf8.gsub!(/\r\n?/, "\n")
      #
      vp004_utf = File.join(vp004 + ".utf")
      vp004_utf8_file = File.new(vp004_utf, 'w+')
      vp004_utf8_file.puts(vp004_utf8)
      vp004_utf8_file.close()
    end


    def collect_data(path)
      File.foreach("." + path + "/" + vipiska_name) do |line|
        case line
          when ACCOUNT_START
            ss = line.gsub "/", "\\"
            day = DATE_PATTERN.match(ss)[1]
            month = DATE_PATTERN.match(ss)[2]
            year = DATE_PATTERN.match(ss)[3]
            vpfile.update_attribute(:file_for_data, "20#{year}-#{month}-#{day}")
            break
        end
      end
    end

    def collect_rahunki(path)
      File.foreach("." + path + "/" + vipiska_name) do |line|
        case line
          when RAHUNOK_START
            a = line.scan(RAHUNOK_PATTERN)
              aa = a[0]
              bb = a[1]
              acc1 = aa
              acc2 = bb
              if valid_acc2?(acc2)
                rahunok = Rahunok.new
                rahunok.number= acc1
                rahunok.code= acc2
                rahunok.vipiska_file_id= vpfile.id
                rahunok.save!
              end
        end
      end
    end

    def collect_rahunok(line)
      a = line.scan(RAHUNOK_PATTERN)
        aa = a[0]
        bb = a[1]
        @acc1 = aa
        @acc2 = bb
        if valid_acc2?
          rahunok = Rahunok.new
          rahunok.number= acc1
          rahunok.code= acc2
          rahunok.vipiska_file_id= vpfile.id
          rahunok.save!
        end
    end

    def valid_acc2?
      r = (acc2 == "13050200" || acc2 == "13050100" || acc2 == "13050300" || acc2 == "13050500") ? true : false
    end

    def collect_files_count(dir)
      files_count = (Dir.entries(dir).count - 2)
      files_count = files_count / 2 if files_count > 1
      vpfile.update_attribute(:files_count_in, files_count)
    end


    def collect_platnik_c(line)
      platnik_c = ""
      b = URC_PATT.match(line)
      unless b.nil?
        bb = b[1]
        platnik_c = "#{bb}" if !bb.nil?
      end
      a = FIZC_PATT.match(line)
      unless a.nil?
        aa = a[1]
        platnik_c = "#{aa}" if !aa.nil?
      end
      platnik_c
    end


    def collect_summa(line)
      a = SUMMA_PATT.match(line)
      aa = a[1]
      "#{aa}" unless aa.nil?
    end

    def collect_bank(line)
      a = BANK_PATT.match(line)
      unless a.nil?
        aa = a[1]
        "#{aa}" unless aa.nil?
      end
    end

    def collect_platnik(line)
      platnik = ""
      a = FIZ_PATT.match(line)
      unless a.nil?
        aa = a[1]
        platnik = "#{aa}"
      end
      b = UR_PATT.match(line)
      unless b.nil?
        bb = b[1]
        platnik = "#{bb}"
      end
      platnik
    end


    def collect_comment(p)
      comment = ""
      p.each_index do |pp|
        if pp > 3
          comment << p[pp]
        end
      end
      plateg.platnik_c= collect_platnik_c(comment)
      comment
    end

    def collect_plateg(lines)

      p = lines.split("\n")

      @plateg = Plateg.new
      plateg.rahunok_id= Rahunok.find_rahunok_id(vpfile.id, acc1)
      plateg.summa= collect_summa(p[0])
      plateg.bank= collect_bank(p[0])
      plateg.platnik= collect_platnik(p[2])
      plateg.comment= collect_comment(p)
      lines["\n"] = " <br /> "
      plateg.content = lines
      plateg.save!

    end


    def collect_plategi(path)

      section = []
      plateg = ""

      File.foreach("." + path + "/" + vipiska_name) do |line|
        case line
          when RAHUNOK_START
            collect_rahunok(line)
          when PLATEG_START
            unless acc2.nil?
              section.pop
              section.push "Plateg"
            end
          when PLATEG_END
            if section == ["Plateg"] && !acc2.nil?
              if valid_acc2?
                collect_plateg(plateg)
                #Rails.logger.debug "#{plateg}"
              end
              plateg = ""
              section.pop
              section.push "Plateg_end"
            end
        end

        case section
          when ["Plateg"]
            plateg << line
          when ["Plateg_end"]
        end

      end

    end


  end

  #----------------------------------------------
  class FileR28 < VPFile

    def work
      work_prepare
      pp = `arj x #{file_name} ./files`
      files_to_utf("/files")
      collect_data("/files")
      collect_files_count("files")
      #collect_rahunki("/files")
      collect_plategi("/files")
    end

    def initialize(f)
      @file = f
      @file_name = f.original_filename
      @vipiska_name = ""
    end


  end

  #----------------------------------------------
  class File004 < VPFile

    def work
      work_prepare
      files_to_utf("")
      collect_data("")
      collect_files_count(".")
      #collect_rahunki("")
      collect_plategi("")
    end

  end


end
