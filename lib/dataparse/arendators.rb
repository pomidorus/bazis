#encoding: utf-8

PERSON_FILE = './lib/dataparse/arendators.txt'

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
    @name.strip!

    #убрать пробелы в начале и в конце
    #@edrpou = l_split[EDRPOU]
    @edrpou = rand(1000000).to_s
    @edrpou.strip!

    edrpou_match
  end

  def edrpou_match
    #if !edrpou_f.nil?
    #  Person.create!({:name => @name, :edrpou => @edrpou})
    #end
    #if !edrpou_u.nil?
    #  Person.create!({:name => @name, :edrpou => @edrpou})
    #end
    unless @edrpou.nil?
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


def arendators_parse(file)
  IO.foreach(file) do |l|
    pp =  ParsePerson.new(l)
    pp.parse
  end
end


PP_PATT = /^(П{2}|ТОВ)/u
PP_NAME = /„(.+?)”/u

class Arendator
  attr_accessor :edrpou, :line, :type, :name

  def initialize(line)
    @line = line

    l_split = line.split(";")
    @edrpou = l_split[EDRPOU]
    @edrpou.strip!

    @name_bad = l_split[NAME]
    @name_bad.strip!
    #@name_bad = downcase_ua(@name_bad)

    name_set
  end


  def downcase_ua(s)
    lit = ['А','Б','В','Г','Д','Е','Ж','З','И','К','Л','М','Н','О','П','Р','С','Т','У','Ф','Х','Ц','Ч','Ш','Щ','Э','Ю','Я','І','Ї','Є','Й']
    lit_s = ['а','б','в','г','д','е','ж','з','и','к','л','м','н','о','п','р','с','т','у','ф','х','ц','ч','ш','щ','э','ю','я','і','ї','є','й']
    lit.each_index do |i|
      s.gsub!(lit[i],lit_s[i])
    end
    return s
  end

  def is_fizikal?
    @edrpou.length == 10
  end

  def is_uridical?
    @edrpou.length == 8
  end

  def what_type
    if is_fizikal?
      return "fiz"
    elsif is_uridical?
      return "ur"
    else
      "non"
    end
  end

  def what_name_bad
    @name_bad
  end

  def what_type_non?
    what_type == "non"
  end

  def what_type_non
    if what_type_non?
      case edrpou
        when edrpou == nil
          "1"
        when edrpou.length > 1
          "2"
      end
    end
  end

  def type
    PP_PATT.match(@name_bad).to_a[1]
  end

  def name_pp
    PP_NAME.match(@name_bad).to_a[1]
  end

  def is_PP?
    type == "ПП"
  end

  def is_TOV?
    type == "ТОВ"
  end


  def name_set
    if is_PP? and is_uridical?
        @name = name_pp
    elsif is_TOV? and is_uridical?
        @name = name_pp
    else
      @name = nil
    end
  end

  def name_cov
    if @name.include?("„")
      return @name.gsub("„","«") + "»"
    else
      return @name
    end
  end

end


#arendator = Arendator.new("452;54;2008-09-19 13:31:52.517000000;гр. Ничипорук Надія Пилипівна;гр. Ничипорук Надія Пилипівна;м. Бориспіль, вул. Київський шлях, 77, кв.19;м. Бориспіль, вул. Київський шлях, 77, кв.19;1376410989;;;;;;;;;0;-1;-1;0;;;;")
#

file = './arendators.txt'


def arendators_parse(file)
  IO.foreach(file) do |l|
    arendator = Arendator.new(l)
    if not arendator.name.nil?

      #puts arendator.type
      #puts arendator.name.strip

      Person.create!({:name => arendator.name_cov.strip, :edrpou => arendator.edrpou})

    end
  end
end
