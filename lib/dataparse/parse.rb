#encoding: utf-8

FIZ_NAME2 = /(\W+?)\s+(\W+?)\.(\W+?)\./u
FIZ_NAME1 = /(\W+?)\s+(\W+?)\s(\W+)/u

PP_PAT = /(П{2}|гр.|ФОП|ФО-П|Приватний підприємець|Фізична особа)\s([А-ЯЄ-ЇР-Ь][а-я]+\s+[А-Я]+.+)/u
PP_FIZ = /[А-Я][а-я]+\s+[А-Я]\.?([а-я]+)?\s+[А-Я]\.?([а-я]+)?/um

EDRPOU_F = /\,(\d{10})\,/um
EDRPOU_U = /\,(\d{8})\,/um
ADDR_PATTERN = /^(\d{5})\,/um

ADDR = /(.+)/um
NAMESHORT = /(.+?)\,/um
NAME = /(.+?)\,/um
DREG = /(.+?)\,/um
USERID = /(\d+)\,/um
OBJECTID = /^(\d+)\,#{USERID}#{DREG}#{NAME}#{NAMESHORT}#{ADDR}/um


class Person
  attr_reader :type, :edrpou

  def initialize

  end

end


class Uridical < Person
  attr_reader :brand

  def name

  end

end


class Fizikal < Person
  attr_reader :imya, :famil, :parent

  def initialize(name, type, edrpou)
    @famil, @imya, @parent = parseName(name)
    @type = type
    @edrpou = edrpou
  end

  def parseName(name)
    if !FIZ_NAME1.match(name).nil?
      [FIZ_NAME1.match(name).to_a[1], FIZ_NAME1.match(name).to_a[2], FIZ_NAME1.match(name).to_a[3]]

    elsif !FIZ_NAME2.match(name).nil?
      [FIZ_NAME2.match(name).to_a[1], FIZ_NAME2.match(name).to_a[2], FIZ_NAME2.match(name).to_a[3]]
    end


  end

  def name
    "#{type} #{famil} #{imya} #{parent} #{edrpou}"
  end

  def urName
    "#{type} #{famil} #{imya} #{parent}"
  end

end


class PersonFactory

  attr_reader :persons


  def initialize(q)
    case q
      when 0
        return Uridical.new
      when 1
        Fizikal.new
    end
  end

  def self.persons
    @persons
  end

  def self.produce(l)

    @persons = []

    object = OBJECTID.match(l.chomp)
    object_a = object.to_a
    addr_s = object_a[6]
    name = object_a[4]

    if !name.nil?
      name.strip!
      if !PP_PAT.match(name).nil?
        type = PP_PAT.match(name).to_a[1]
        name_f = PP_PAT.match(name).to_a[2]
        edrpou = EDRPOU_F.match(addr_s)[1] if !EDRPOU_F.match(addr_s).nil?
        @persons << Fizikal.new(name_f,type,edrpou)
      end
    end
  end

end


def parse(filename)

  file = File.new('pers.txt', 'w')

  IO.foreach(filename) do |l|
    PersonFactory.produce(l)
    PersonFactory.persons.each do |p|
      puts p.name
    end
  end

  file.close
end


parse('personu.txt')



  #file = File.new(filename, 'r')
  #puts file.gets
  #puts file.gets.chomp
  #file.close

  #open(filename) do |row|
  #  row.read.each_line do |l|
  #    puts l
  #  end
  #end

  #objectid = OBJECTID.match(l)[0]
  #puts l

    #ss =  ADDR_PATTERN.match(addr_s)
    #edrpou_u = EDRPOU_U.match(addr_s)
    #edrpou_f = EDRPOU_F.match(addr_s)
    #r = "#{edrpou_u.to_a[1]};#{edrpou_f.to_a[1]};#{name}"

    #case q
    #  when 0
    #    return Uridical.new
    #  when 1
    #    return Fizikal.new
    #end
