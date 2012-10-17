module Dashboard

  def index_vpfiles
    #количество файлов
    @vpfile= VipiskaFile.all
    @vpfile_count= @vpfile.count
    #добавленные сегодня файлы
    @vpfile_today= VipiskaFile.today_vp
    @vpfile_today_count= @vpfile_today.count
    #добавленные не сегодня файлы
    @vpfile_last= VipiskaFile.last_vp(100)
    @vpfile_last_count= @vpfile_last.count
  end


end