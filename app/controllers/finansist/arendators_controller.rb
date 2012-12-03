#encoding: utf-8

class Finansist::ArendatorsController < ApplicationController
  def index

    @title = "Арендаторы"

    @arendators = Person.order(:name)

    @sum_all = []
    @plateg_count = []
    @arendators.each do |arendator|
      plategi = Plateg.find_all_by_platnik(arendator.edrpou)

      sum = 0.00
      count = 0
      plategi.each do |plateg|
        sum += plateg.summa.to_f
        count += 1
      end
      #@sum.nil? : sum = 0.0
      if !sum.nil?
        sum = sum.round(2)
      else
        sum = 0.0
      end
      @sum_all << sum
      @plateg_count << count
    end

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

  @plategi = Plateg.find_all_by_platnik(@arendator.edrpou)

  @sum = 0.00
  @plategi.each do |plateg|
    @sum += plateg.summa.to_f
  end

  @sum = @sum.round(2)

  end

  def table

  end

end
