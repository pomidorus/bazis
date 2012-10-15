#encoding: utf-8

require "iconv"

module VP

  class Files
    attr_accessor :files, :file_current

    ACCOUNT_START = /ВИПИСКА по РАХУНКУ/u
    DATE_PATTERN = /([0-9][0-9])\\(.*?)\\([0-9][0-9])/

    @file_name = ""
    @file = nil

    def self.file_ext
      @file_name[-3,3].downcase
    end

    def self.file_r28?
      if file_ext == "r28"
        true
      else
        false
      end
    end


    def self.file_004?
      if file_ext == "004"
        true
      else
        false
      end
    end

    def self.file_r28_work

      vpfile = VipiskaFile.create({:file_name => @file.original_filename, :upload_at => Date.today, :file_for_data => "2012-10-10",
                                   :file_size => get_file_size(@file)})
      vpfile.save!

      pwd = Dir.pwd
      vpfile.create_dir_r28

      # Сохраняю файл в директорию. Каждый файл должен быть в своей директории
      File.open(@file.original_filename, 'wb') {|f| f.write(@file.read)}
      pp = `arj x #{@file.original_filename} ./files`

      #Количество файлов
      vpfile.files_count_in= Dir.entries("files").count - 2
      vpfile.save!

      #Дата выписки

      Dir.chdir(pwd)

    end

    def self.file_004_work

      vpfile = VipiskaFile.create({:file_name => @file.original_filename, :upload_at => Date.today, :file_for_data => "2012-10-10",
                                   :file_size => get_file_size(@file)})
      vpfile.save!

      #pwd = Dir.pwd
      vpfile.create_dir_004
      fne = vpfile.file_name_ex

      # Сохраняю файл в директорию. Каждый файл должен быть в своей директории
      File.open(@file_name, 'wb') {|f| f.write(@file.read)}
      file_004_to_utf(fne)

      #Дата выписки
      File.foreach(@vp004_utf8_filename) do |line|
        case line
          when ACCOUNT_START
            ss = line.gsub "/", "\\"
            day = DATE_PATTERN.match(ss)[1]
            month = DATE_PATTERN.match(ss)[2]
            year = DATE_PATTERN.match(ss)[3]
            vpfile.file_for_data= "20#{year}-#{month}-#{day}"
            vpfile.save!
            break
        end
      end

      #Количество файлов
      vpfile.files_count_in= 1
      vpfile.save!

      #Счета
      #Нужно пройти по файлу выписок и собрать счета в один массив
      a1, a2 = collect_accounts_004
      a1.each_index do |a|
        @acc2 = a2[a]
        if valid_acc2?
          rahunok = Rahunok.new
          rahunok.number= a1[a]
          rahunok.code= a2[a]
          rahunok.vipiska_file_id= vpfile.id
          rahunok.save!
        end
      end

      #Платежи по нужным кодам 13050*
      collect_plategi_004(vpfile.id)

      #Dir.chdir(pwd)

    end

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


    def self.collect_plategi_004(id)

      section = []
      plateg = ""

      File.foreach(@vp004_utf8_filename) do |line|
        case line
          when RAHUNOK_START
            collect_rahunok(line)
          when PLATEG_START
            if !@acc2.nil?
              section.pop
              section.push "Plateg"
            end
          when PLATEG_END
            if section == ["Plateg"] && !@acc2.nil?
              if valid_acc2?
                collect_plateg(plateg,id)
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


    def self.valid_acc2?
      if @acc2 == "13050200" || @acc2 == "13050100" || @acc2 == "13050300" || @acc2 == "13050500"
        true
      else
        false
      end

    end


    def self.collect_plateg(plateg, id)

      @summa, @bank, @platnik, @platnik_c = nil, nil, nil, nil
      p = plateg.split("\n")

      collect_summa(p[0])
      collect_bank(p[0])
      collect_platnik(p[2])

      comment = ""

      p.each_index do |pp|
        if pp > 3
          comment << p[pp]
        end
      end

      collect_comment(comment)

      plateg = Plateg.new
      plateg.rahunok_id= find_rahunok_id(id, @acc1)
      plateg.summa= @summa
      plateg.bank= @bank
      plateg.platnik= @platnik
      plateg.platnik_c= @platnik_c
      plateg.comment= comment
      plateg.save!

    end


    def self.find_rahunok_id(id, acc1)
      w = Rahunok.where("number = :number AND vipiska_file_id = :vpid", :number => acc1, :vpid => id).first
      w.id
    end


    def self.collect_comment(line)

      b = URC_PATT.match(line)
      if !b.nil?
        bb = b[1]
        @platnik_c = "#{bb}" if !bb.nil?
      end

      a = FIZC_PATT.match(line)
      if !a.nil?
        aa = a[1]
        @platnik_c = "#{aa}" if !aa.nil?
      end

    end


    def self.collect_summa(line)
      a = SUMMA_PATT.match(line)
      aa = a[1]
      @summa = "#{aa}" if !aa.nil?
    end

    def self.collect_bank(line)
      a = BANK_PATT.match(line)
      aa = a[1]
      @bank = "#{aa}" if !aa.nil?
    end

    def self.collect_platnik(line)

      a = FIZ_PATT.match(line)
      if !a.nil?
        aa = a[1]
        @platnik = "#{aa}"
      end

      b = UR_PATT.match(line)
      if !b.nil?
        bb = b[1]
        @platnik = "#{bb}"
      end

    end


    def self.collect_rahunok(line)
      a = line.scan(RAHUNOK_PATTERN)
      aa = a[0]
      @acc1 = aa
      aa = a[1]
      @acc2 = aa
    end



    def self.collect_accounts_004

      acc1 = []
      acc2 = []
      File.foreach(@vp004_utf8_filename) do |line|
        case line
          when RAHUNOK_START
            a = line.scan(RAHUNOK_PATTERN)
              aa = a[0]
              acc1 << aa
              aa = a[1]
              acc2 << aa
        end
      end

      return acc1, acc2
    end


    def self.get_file_size(file)
      fs = (file.tempfile.size/1024.0).round(1).to_s
      fs["."] = ","
      "#{fs} КБ"
    end

    def self.upload(file)

      @file = file
      @file_name = file.original_filename

      if file_r28?
        file_r28_work
      end

      if file_004?
        file_004_work
      end

      ##TODO: Возможность загрузки файлов 004
      ##tt = `arj t #{file.original_filename}`
    end

    def self.today_vp
      VipiskaFile.find_all_by_upload_at Date.today, :order => "created_at desc"
    end

    def self.last_vp
      VipiskaFile.where("upload_at < :date", :date => Date.today).order("created_at desc").limit(5)
    end

    #Конвертация файла из кодировки виндовса в утф-8
    def self.file_004_to_utf(vp004_filename)
      vp004 = File.join(vp004_filename + ".004")
      @vp004_utf8_filename = File.join(vp004_filename + "_utf8.004")

      vp004_file = File.open(vp004, 'r')
      c = vp004_file.read()
      vp004_file.close()
      #
      conv = Iconv.new('UTF-8','CP1251')
      vp004_utf8 = conv.iconv(c)
      vp004_utf8.gsub!(/\r\n?/, "\n")
      #
      vp004_utf8_file = File.new(@vp004_utf8_filename, 'w+')
      vp004_utf8_file.puts(vp004_utf8)
      vp004_utf8_file.close()
    end

    def self.download(id)
      if !(id.nil?) then
        vpfile = VipiskaFile.find_by_id id
        "#{Rails.root}/public/r28/#{id}/#{vpfile.file_name}"
      end
    end


  end


  class VPFile

  end


  class FileR28 < VPFile

  end

end

