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
        @vpfile = VipiskaFile.all
      end
    end

  end
end
