#encoding: utf-8

class Finansist::PlategiController < ApplicationController
  def index

  @title = "Платежи"
  @plategi ||= Plateg.order(:summa)
  #@plategi ||= Plateg.all

  respond_to do |format|
    format.html
    format.csv { send_data @plategi.to_csv }
    format.xls # { send_data @plategi_xls.to_csv }
  end

  end

  def show

    @id = params[:id]
    @code = params[:code]
    @plategi = Plateg.find_all_by_vipiska_file_id_and_rahunok_code(@id,@code)
    @plategi_count = @plategi.count
    @plategi_summa = Plateg.summa_plateg(@plategi)

    @vipiska = VipiskaFile.find_by_id @id
  end

  def all

  end

end
