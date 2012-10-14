#encoding: utf-8

RAHUNOK_START = /Рахунок:/u
RAHUNOK_PATTERN = /\b[0-9]+\b/um

def collect_accounts_004
  acc1 = []
  acc2 = []

  File.foreach('vp111CU0_utf8.004') do |line|
    case line
      when RAHUNOK_START
        a = line.scan(RAHUNOK_PATTERN)
          aa = a[0]
          acc1 << aa
          aa = a[1]
          acc2 << aa
    end
  end

  return acc1, acc2

end


a1, a2 = collect_accounts_004

puts a1.inspect
puts a2.inspect
