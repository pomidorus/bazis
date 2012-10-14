#encoding: utf-8


RAHUNOK_START = /Рахунок:/u
RAHUNOK_PATTERN = /\b[0-9]+\b/um
PLATEG_START = /\b(?:A|R|B)..\b/um
PLATEG_END = /^---/u
SUMMA_PATT = /\s+([0-9]+\.[0-9]+)/u
BANK_PATT = /...\s+[0-9]{8}\s+([0-9]{6})/u
FIZ_PATT = /^\d{10}/u
UR_PATT = /^\d{8}/u
FIZC_PATT = /;(\d{10})/u
URC_PATT = /(\d{8})/u


def collect_plategi_004

  section = []
  plateg = ""

  File.foreach('vp111CU0_utf8.004') do |line|
    case line
      when RAHUNOK_START
        collect_rahunok(line)
      when PLATEG_START
        if !@acc2.nil?
          section.pop
          section.push "Plateg"
          puts section.inspect
        end
      when PLATEG_END
        if section == ["Plateg"] && !@acc2.nil?
          collect_plateg(plateg)
          plateg = ""

          section.pop
          section.push "Plateg_end"
          puts section.inspect
        end
    end

    case section
      when ["Plateg"]
        plateg << line
      when ["Plateg_end"]
        #collect_plateg(plateg)
        #plateg = ""
    end

  end

end


def collect_plateg(plateg)

  @summa, @bank, @platnik, @platnik_c = nil, nil, nil, nil
  p = plateg.split("\n")

  collect_summa(p[0])
  collect_bank(p[0])
  collect_platnik(p[2])

  comment = ""

  p.each_index do |pp|
    if pp > 3
      comment << p[pp]
    end
  end

  collect_comment(comment)


  puts @acc1, @acc2, @summa, @bank, @platnik, @platnik_c, comment
end


def collect_comment(line)

  a = line.scan(FIZC_PATT)
  aa = a[0]
  a = line.scan(URC_PATT)
  bb = a[0]

  @platnik_c = bb if !bb.nil?
  @platnik_c = aa if !aa.nil?

end


def collect_summa(line)
  a = line.scan(SUMMA_PATT)
  aa = a[0]
  @summa = aa
end

def collect_bank(line)
  a = line.scan(BANK_PATT)
  aa = a[0]
  @bank = aa
end

def collect_platnik(line)
  a = line.scan(FIZ_PATT)
  aa = a[0]
  a = line.scan(UR_PATT)
  bb = a[0]

  @platnik = aa if !aa.nil?
  @platnik = bb if !bb.nil?
end


def collect_rahunok(line)
  a = line.scan(RAHUNOK_PATTERN)
  aa = a[0]
  @acc1 = aa
  aa = a[1]
  @acc2 = aa
end


collect_plategi_004