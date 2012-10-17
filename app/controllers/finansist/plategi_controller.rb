class Finansist::PlategiController < ApplicationController
  def index
  end

  def show
    @id = params[:id]
    @code = params[:code]
    @plategi = Plateg.find_all_by_vipiska_file_id_and_rahunok_code(@id,@code)
    @plategi_count = @plategi.count
    @plategi_summa = Plateg.summa_plateg(@plategi)

    @vipiska = VipiskaFile.find_by_id @id
  end
end
