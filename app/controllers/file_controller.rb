#encoding: utf-8


class FileController < ApplicationController
  before_filter :authenticate_user!, :loadModule
  #before_filter :loadModule

  def loadModule
    load "#{Rails.root}/lib/vpfiles.rb"
  end

  def upload

    VP::Files.upload(params[:file])

    if current_user.finansist?
      redirect_to files_path
    end
    if current_user.secretar?
      redirect_to root_path
    end
  end

  def file
    if !(params[:id].nil?) then
      id = params[:id]
      vpfile = VipiskaFile.find_by_id id
      send_file "#{Rails.root}/public/r28/#{id}/#{vpfile.file_name}"
    end
  end

  def upload_s

    file = params[:file]
    file_for_day = params[:file_data]

    # Создаю модель для хранения в базе данных
    vpfile = VipiskaFile.new
    vpfile.file_name= file.original_filename
    vpfile.upload_at= Date.today
    vpfile.file_for_data= file_for_day

    fs = (file.tempfile.size/1024.0).round(1).to_s
    fs["."] = ","
    vpfile.file_size= "#{fs} КБ"

    vpfile.save!

    id = vpfile.id

    # Работаю с директорией

    directory = "#{Rails.root}/public/r28"
    Dir.chdir(directory)

    # Создаю директорию для файла
    new_file_dir = id.to_s
    Dir.mkdir(new_file_dir, 0700)
    Dir.chdir(new_file_dir)

    Dir.mkdir("files", 0700)

    # Сохраняю файл в директорию. Каждый файл должен быть в своей директории

    #path = File.join(directory, file.original_filename)
    File.open(file.original_filename, 'wb') {|f| f.write(file.read)}
    tt = `arj t #{file.original_filename}`
    pp = `arj x #{file.original_filename} ./files`

    # Получаю список файлов
    vpfile.files_count_in= Dir.entries("files").count - 2
    vpfile.save!

    logger.debug "New file: #{file.inspect} #{file_for_day.inspect}"
    logger.debug "Test archive: #{tt}"
    logger.debug "New vpfile: #{vpfile.inspect}"
    logger.debug "Current dir: #{Dir.pwd.inspect}"
    logger.debug "Root: #{Rails.root}/public/"

    # Читаю содержимое файлов
    #FileUtils.chmod 0775, path, :verbose => true
    #Dir.chdir(directory)
    #system 'arj x /home/andrus/dev/proj/SR/bazis_dev_upload/public/r28/OFU-3012.R28 /home/andrus/dev/proj/SR/bazis_dev_upload/public/r28/'
    #pp = `arj e OFU*`

    redirect_to "/"
    #render :text => file.original_filename + ' ' + path + ' ' + directory + ' ' + __FILE__  + ' ' + pp
    #+ pp + __FILE__

  end

end
