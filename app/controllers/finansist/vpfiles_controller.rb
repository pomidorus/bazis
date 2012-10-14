#encoding: utf-8

class Finansist::VpfilesController < ApplicationController

  def index
    #количество файлов
    vpfile ||= VipiskaFile.all
    @vpfile_count ||= vpfile.count
    #добавленные сегодня файлы
    @vpfile_today ||= VP::Files.today_vp
    @vpfile_today_count ||= @vpfile_today.count
    #добавленные не сегодня файлы
    @vpfile_last ||= VP::Files.last_vp
    @vpfile_last_count ||= @vpfile_last.count
  end

  def upload
    #vpfile = VipiskaFile.upload(params[:file], params[:file_data])
    #redirect_to :controller => 'finansist/vpfiles', :action => 'index'
  end

  def file
    #if !(params[:id].nil?) then
    #  id = params[:id]
    #  vpfile = VipiskaFile.find_by_id id
    #  send_file "#{Rails.root}/public/r28/#{id}/#{vpfile.file_name}"
    #end
  end

end
