#encoding: utf-8

module VP

  class Files
    attr_accessor :files, :file_current

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

      pwd = Dir.pwd
      vpfile.create_dir_004

      # Сохраняю файл в директорию. Каждый файл должен быть в своей директории
      File.open(@file.original_filename, 'wb') {|f| f.write(@file.read)}
      #pp = `arj x #{file.original_filename} ./files`

      #Количество файлов
      vpfile.files_count_in= 1
      vpfile.save!

      #Дата выписки

      Dir.chdir(pwd)


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


  end


  class VPFile

  end


  class FileR28 < VPFile

  end

end

