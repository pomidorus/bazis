#encoding: utf-8

require "iconv"

def convert_vp004_to_utf8(vp004_filename)
  vp004 = File.join(File.dirname(__FILE__), vp004_filename + ".004")
  vp004_utf8_filename = File.join(File.dirname(__FILE__), vp004_filename + "_utf8.004")

  puts vp004
  puts vp004_utf8_filename

  vp004_file = File.open(vp004, 'r')
  c = vp004_file.read()
  vp004_file.close()
  #
  conv = Iconv.new('UTF-8','CP1251')
  vp004_utf8 = conv.iconv(c)
  vp004_utf8.gsub!(/\r\n?/, "\n")
  #
  vp004_utf8_file = File.new(vp004_utf8_filename, 'w+')
  vp004_utf8_file.puts(vp004_utf8)
  vp004_utf8_file.close()
end


convert_vp004_to_utf8("vp111CU0")