#encoding: utf-8

class Finansist::ArendatorsController < ApplicationController
  def index

    @title = "Арендаторы"
    @arendators = Person.order(:name)

    vid = params[:vid]
    if vid.nil?
      render 'finansist/arendators/index'
    end
    case vid
      when "table"
        render 'finansist/arendators/table'
      when "list"
        render 'finansist/arendators/index'
    end

  end

  def show

  id = params[:id]
  @arendator = Person.find(id)
  @title = @arendator.name


  end

  def table

  end

end
