# encoding: utf-8

class VipiskaFile < ActiveRecord::Base
  attr_accessible :download_count, :file_name, :upload_at, :file_size, :file_for_data

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
    if !file_for_data.nil?
      "#{file_for_data.day} #{file_for_data.month_to_word} <span>#{file_for_data.year}</span>"
    elsif
      ""
    end
  end

  def file_data_small
    "#{file_for_data.day}.#{file_for_data.month}.#{file_for_data.year}"
  end

  def create_dir_r28(path="public/r28")

    directory = "#{Rails.root}/#{path}"
    Dir.chdir(directory)
    # Создаю директорию для файла
    new_file_dir = id.to_s
    Dir.mkdir(new_file_dir, 0700)
    Dir.chdir(new_file_dir)

    Dir.mkdir("files", 0700)

  end

  def create_dir_004(path="public/r28")

    directory = "#{Rails.root}/#{path}"
    Dir.chdir(directory)
    # Создаю директорию для файла
    new_file_dir = id.to_s
    Dir.mkdir(new_file_dir, 0700)
    Dir.chdir(new_file_dir)

  end


end


