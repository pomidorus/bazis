
PERSON_FILE = './lib/dataparse/pers1u.txt'

OBJECTID = 0
USERID = 1
DREG = 2
NAME = 3
NAMESHORT = 4
ADDRESS = 5
ADDRESSPOST = 6
EDRPOU = 7
BANK = 8
BANKCODE = 9
ACCOUNT = 10
CONTACT = 11
TEL = 12
PASSPNUM = 13
PASSPDATE = 14
PASSPWHOM = 15
ISJURISTIC = 16
SC_FIRMFORMS_ID = 17
SC_IDENTCARD_ID = 18
IS_BALANCE_OWNER = 19
TAX_LICENCE = 20
TAX_NUMBER = 21
MAIN_PERSON_NAME = 22
MAIN_PERSON_POST = 23

EDRPOU_F = /^(\d{10})$/um
EDRPOU_U = /^(\d{8})$/um

class ParsePerson

  attr_reader :l,:name,:edrpou

  def initialize(string)
    @l = string
  end

  def parse
    l_split = @l.split(";")
    @name = l_split[NAMESHORT]
    @edrpou = l_split[EDRPOU]

    edrpou_match
  end

  def edrpou_match
    if !edrpou_f.nil?
      Person.create!({:name => @name, :edrpou => @edrpou})
    end
    if !edrpou_u.nil?
      Person.create!({:name => @name, :edrpou => @edrpou})
    end
  end

  def edrpou_f
    EDRPOU_F.match(@edrpou)
  end

  def edrpou_u
    EDRPOU_U.match(@edrpou)
  end
end


def parsePersonFile(file)
  IO.foreach(file) do |l|
    pp =  ParsePerson.new(l)
    pp.parse
  end
end
