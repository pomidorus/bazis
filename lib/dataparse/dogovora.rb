
DOGOVORA_FILE = './lib/dataparse/dogovora.txt'

OBJECTID = 0
USERID = 1
DREG = 2
LEASENUM = 3
LEASEDATE = 4
TERM = 5
LOCATION = 6
DECISIONDOCID = 7
VALUATION = 8
LANDFUNCTION = 9
UKCVZID = 10
LANDUSE = 11
S_STATUSLEASEID = 12
S_TYPELEASEID = 13
PUBLICREGISTERNUM = 14
PUBLICREGISTERDATE = 15
DECREEDATE = 16
TOTALPLOTTAGE = 17
CONSTRUCTIONS = 18
AUCTION = 19
TOTALPLOTBUILDIN = 20
CADASTRENUM = 21
ISDIVIDED = 22
PLOTTAGE1 = 23
RATEPERCENT1 = 24
RENT1 = 25
PLOTTAGE2 = 26
RATEPERCENT2 = 27
RENT2 = 28
RENTYEAR = 29
RENTMONTH = 30
STARTDATE = 31
ENDPLAN = 32
ENDFACT = 33
ISLANDPROJECT = 34
RENTYEARINDEX = 35
RENTMONTHINDEX = 36
TYPEFINERATE = 37
FINERATE = 38
LASTDAYPAYMENT = 39
SC_TYPEBUILDINGID = 40
S_BALANCEOWNERID = 41
IMAGEID = 42
VALUATIONDATE = 43


class Dogovor
  attr_accessor :number

  def initialize(line)
    l_split = line.split(";")
    @number = l_split[LEASENUM]
    #puts @number
    @number.strip!
  end

end


def dogovora_parse(file)
  IO.foreach(file) do |l|
    dogovor = Dogovor.new(l)
    unless dogovor.number == ""
      DogovorArenda.create!({:number => dogovor.number})
    end
    end
end
