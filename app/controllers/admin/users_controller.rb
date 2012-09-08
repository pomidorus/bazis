class Admin::UsersController < ApplicationController
  before_filter :authenticate_admin!

  def index
    @users = User.all(:order => 'surname')
  end

  def show
    id = params[:id]
    @user = User.find_by_id id
  end

  def edit
  end
end
