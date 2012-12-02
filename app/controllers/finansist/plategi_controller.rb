#encoding: utf-8

class Finansist::PlategiController < ApplicationController
  def index

  @title = "Платежи"

  end

  def show

    #если айди равен нулю

    if params[:id].nil?

      render :text => "fuck you"

    end

    #@id = params[:id]
    #@code = params[:code]
    #@plategi = Plateg.find_all_by_vipiska_file_id_and_rahunok_code(@id,@code)
    #@plategi_count = @plategi.count
    #@plategi_summa = Plateg.summa_plateg(@plategi)
    #
    #@vipiska = VipiskaFile.find_by_id @id
  end

  def all

  end

end
