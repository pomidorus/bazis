class DashBoardController < ApplicationController
  before_filter :do_authentication, :loadModule
  include Dashboard

  def loadModule
    load "#{Rails.root}/lib/dashboard.rb"
    load "#{Rails.root}/lib/vp/file_factory.rb"
  end

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
        index_vpfiles
      end
    end
  end

end


