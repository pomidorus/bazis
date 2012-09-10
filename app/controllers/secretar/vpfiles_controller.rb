class Secretar::VpfilesController < ApplicationController
  before_filter :authenticate_user!

  def index
    vpfiles = VipiskaFile.all
    render :json => vpfiles.to_json
  end

end
