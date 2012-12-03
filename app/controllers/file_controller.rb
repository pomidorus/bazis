#encoding: utf-8


class FileController < ApplicationController
  before_filter :authenticate_user!, :loadModule
  #before_filter :loadModule

  def loadModule
    load "#{Rails.root}/lib/vpfiles.rb"
    load "#{Rails.root}/lib/vp/file_factory.rb"
  end

  def upload
    VP::Files.upload(params[:file])

    redirect_to files_path if current_user.finansist?
    redirect_to root_path if current_user.secretar?
  end

  def file
    send_file VP::Files.download(params[:id])
  end

end
