#encoding: utf-8

module REVP



  class Plateg

    PS3 = /PS3/um
    R01 = /R01/um

    attr_reader :source, :code

    def initialize( source )
      @source = source
      parse
    end

    def parse
      #puts 'plateg parse'
      section = []

      @source.each do |s|
        case s
          when PS3
            section.pop
            section.push "PS3"
          when R01
            section.pop
            section.push "R01"
        end

        case section
          when ["R01"]
            case s
              when R01
                s.gsub!(/\s+/," ")
                puts s
                w = s.match(/(\b...\b)\s+([0-9]+)\s+([0-9]+)\s+([0-9]+)\s+([0-9]+)\s+([0-9]+)\s+([0-9]+\.[0-9]+)/)
                if !w.nil?
                  puts "#{w[1]}"
                else

                end
            end
        end
      end

    end

  end




  class Vipiska

    ACCOUNT_START = /ВИПИСКА по РАХУНКУ/u
    DATE_PATTERN = /([0-9][0-9])\\(.*?)\\([0-9][0-9])/
    RAHUNOK_START = /Рахунок:/u
    RAHUNOK_PATTERN = /\b[0-9]+\b/um
    PLATEG_START = /\b(?:P|R|K)..\b/um
    PLATEG_END = /Всього оборотiв/u

    attr_reader :source, :day, :month, :year,
                :acc1, :acc2, :plategi

    def initialize( source )
      @source = source
      @plategi = []
      parse
    end

    def print
      #puts "Day: #{day} Month: #{month} Year: #{year} Acc1: #{acc1} Acc2: #{acc2} "
      @plategi.each do |p|
        puts p.source[0]
      end
      #puts @plategi[0].source[0]
    end

    def parse

      #puts 'vipiska parse'

      p_start = false
      ss = []
      count = 0
      @source.each do |s|

        case s
          when ACCOUNT_START
            ss = s.gsub "/", "\\"
            @day = DATE_PATTERN.match(ss)[1]
            @month = DATE_PATTERN.match(ss)[2]
            @year = DATE_PATTERN.match(ss)[3]
          when RAHUNOK_START
            a = s.scan(RAHUNOK_PATTERN)
            if !a[0].nil?
              @acc1 = a[0]
            end
            if !a[1].nil?
              @acc2 = a[1]
            end
          when PLATEG_START
            if p_start != false
              @plategi.push Plateg.new(ss)
            end
            count = 0
            ss = []
            p_start = true
          when PLATEG_END
            @plategi.push Plateg.new(ss)
            p_start = false
        end

        if p_start
          ss[count] = s
          count += 1
        end
      end
    end

  end


  class BankParser

    attr_reader :vipiski

    ACCOUNT_START = /ВИПИСКА по РАХУНКУ/u
    ACCOUNT_PATTERN = /\b[0-9]+\b/um
    ACCOUNT_END = /==/um


    def initialize ( source )
      @source = source
      @buffer = ""
      @vipiski = []
    end

    def account_count
      return @vipiski.count
    end

    def account_arenda(ac='13050200')
      w = []
      @vipiski.each do |vp|
        if vp.acc2 == ac
          w << vp
        end
      end
      return w
    end

    #Парсинг по выпискам
    def parse

      puts 'account pars'

      ss = []
      count = 0
      a_start = false
      File.foreach(@source) do |line|
        case line
          when ACCOUNT_START
            if a_start != false
              @vipiski.push Vipiska.new(ss)
            end
            count = 0
            ss = []
            a_start = true
          when ACCOUNT_END
            @vipiski.push Vipiska.new(ss)
            a_start = false

        end
        if a_start
          ss[count] = line
          count += 1
        end
      end

    end

  end


  class BankFile

    def initialize( source = nil )
      return if source.nil?
      if source.kind_of? File
        @bankparser = REVP::BankParser.new source
        @bankparser.parse
      end
    end

    def accounts
      #Разбить на выписки
      #@bankparser.vipiski.each do |a|
      #  a.parse
      #end

      arenda = @bankparser.account_arenda
      arenda.each do |a|
        #a.parse
      end
      #@bankparser.accounts[0].parse
      #@bankparser.accounts[0].print
      return true
    end

  end

end