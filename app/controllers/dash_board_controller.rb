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

      # Секретарь и Финансист
      if current_user.secretar?  then
        #количество файлов
        vpfile ||= VipiskaFile.all
        @vpfile_count ||= vpfile.count

        #добавленные сегодня файлы
        @vpfile_today ||= VipiskaFile.today_vp
        @vpfile_today_count ||= @vpfile_today.count

        #добавленные не сегодня файлы
        @vpfile_last ||= VipiskaFile.last_vp
        @vpfile_last_count ||= @vpfile_last.count
      end

    end

  end
end


