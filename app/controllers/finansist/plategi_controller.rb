class Finansist::PlategiController < ApplicationController
  def index
  end

  def show
    @id = params[:id]

    @plategi = Plateg.find_all_by_vipiska_file_id_and_rahunok_code(@id,"13050200")
    @plategi_count = @plategi.count
    @plategi_summa = Plateg.summa_plateg(@plategi)

    @vipiska = VipiskaFile.find_by_id @id
    #@rahunki = Rahunok.find_all_by_vipiska_file_id @id
    #
    #@plategi = {}
    #@plategi_count = 0
    #@rahunki.each do |rahunok|
    #  if rahunok.code == "13050200"
    #    @plategi.store(rahunok.number, Plateg.find_all_by_rahunok_id(rahunok.id))
    #    @plategi_count += Plateg.find_all_by_rahunok_id(rahunok.id).count
    #  end
    #end
    #
    #@plategi_summa = 0

    #logger.debug "Rahunki #{@plategi.inspect}"
  end
end
