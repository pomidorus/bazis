class Admin::RolesController < ApplicationController
  before_filter :authenticate_admin!

  def index
    @roles = Role.all(:order => 'name')

    # find role users

    @ruc = Hash.new
    @roles.each do |role|
      @ruc[role.id] = role.user.count
    end

  end

  def show

    id = params[:id]
    @role = Role.find_by_id id


    # find left right role

    @a = Array.new
    r = Role.all(:order => 'name')
    r.each do |r|
      @a << r.id
    end

    l = @a.length

    role_index = @a.index(@role.id)
    role_left_id = @a[role_index-1]
    if (role_index+1) == l then
      role_right_id = @a[0]
    else
      role_right_id = @a[role_index+1]
    end

    @role_left = Role.find_by_id role_left_id
    @role_right = Role.find_by_id role_right_id

    #

    @role_users = @role.user.order 'surname'

  end

end
