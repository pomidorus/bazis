# encoding: utf-8

class VipiskaFile < ActiveRecord::Base
  attr_accessible :download_count, :file_name, :upload_at

  def date_ukr
    y = upload_at.year
    m = upload_at.month
    m_ukr = ['sicen','dod','sicen','sicen','sicen','sicen','sicen','sicen','sicen','sicen','sicen','sicen']
    m_rus = ['','январь','февраль','март','апрель','май','июнь','июль','август','сентябрь','октябрь','ноябрь','декабрь']
    d = upload_at.day
    return "#{d} #{m_rus[m]}"
  end

  def file_ext
    file_name[-3,3].downcase
  end

  def file_name_ex
    s = file_name.split('.')
    return s[0]
  end

  def file_upload_data
    "#{upload_at.day} #{upload_at.month_to_word} #{upload_at.year}"
  end

  def file_upload_data_small
    "#{upload_at.day}.#{upload_at.month}.#{upload_at.year}"
  end

  def file_data
    "#{file_for_data.day} #{file_for_data.month_to_word} <span>#{file_for_data.year}</span>"
  end

  def file_data_small
    "#{file_for_data.day}.#{file_for_data.month}.#{file_for_data.year}"
  end

  def self.today_vp
    self.find_all_by_upload_at Date.today, :order => "created_at desc"
  end

  def self.last_vp
    self.where("upload_at < :date", :date => Date.today).order("created_at desc").limit(5)
  end


  def self.upload(file, file_data)

    #TODO: Возможность загрузки файлов 004

    logger.debug "New file: #{file.inspect} #{file_data.inspect}"

    vpfile = self.new
    vpfile.file_name= file.original_filename
    vpfile.upload_at= Date.today
    vpfile.file_for_data= file_data

    fs = (file.tempfile.size/1024.0).round(1).to_s
    fs["."] = ","
    vpfile.file_size= "#{fs} КБ"
    vpfile.save!


    id = vpfile.id
    # Работаю с директорией

    create_dir_id(id)

    # Сохраняю файл в директорию. Каждый файл должен быть в своей директории
    File.open(file.original_filename, 'wb') {|f| f.write(file.read)}
    tt = `arj t #{file.original_filename}`
    pp = `arj x #{file.original_filename} ./files`

    # Получаю количество файлов
    vpfile.files_count_in= Dir.entries("files").count - 2
    vpfile.save!

    # Получаю список всех файлов

    return vpfile
  end


  def create_dir_id(id)
    directory = "#{Rails.root}/public/r28"
    Dir.chdir(directory)

    # Создаю директорию для файла
    new_file_dir = id.to_s
    Dir.mkdir(new_file_dir, 0700)
    Dir.chdir(new_file_dir)

    Dir.mkdir("files", 0700)
  end


end


#extend Date class

class Date

  MONTHNAMESRU = ['','января','февраля','марта','апреля','мая','июня','июля','августа','сентября','октября','ноября','декабря']

  def month_to_word
    MONTHNAMESRU[month]
  end

end


