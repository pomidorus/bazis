#encoding: utf-8

class Finansist::VpfilesController < ApplicationController
  before_filter :do_authentication, :loadModule
  include Dashboard

  def loadModule
    load "#{Rails.root}/lib/dashboard.rb"
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
    index_vpfiles
  end

  def upload
  end

  def file
  end

end
