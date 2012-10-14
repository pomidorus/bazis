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
    send_file VP::Files.download(params[:id])
  end

end
