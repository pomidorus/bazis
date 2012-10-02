class DashBoardController < ApplicationController
  before_filter :do_authentication

  def do_authentication

    if not admin_signed_in? then
      authenticate_user!
    end

    if not user_signed_in? then
      authenticate_admin!
    end
  end

  def index

    if user_signed_in? then
      if current_user.secretar? then

        #количество файлов
        vpfile= VipiskaFile.all
        @vpfile_count = vpfile.count

        #добавленные сегодня файлы
        @vpfile_today= VipiskaFile.find_all_by_upload_at Date.today, :order => "created_at desc"
        @vpfile_today_count= @vpfile_today.count

        #not today
        @vpfile_last= VipiskaFile.where("upload_at < :date", :date => Date.today)
        @vpfile_last_count= @vpfile_last.count
      end
    end

  end
end
