#encoding: utf-8

require "test/unit"
require "./lib/dataparse/arendators.rb"


class ArendatorsParseTest < Test::Unit::TestCase

  def test_arendator_edrpou_is_true
    line =  "664;54;2008-07-16 08:41:30.843000000;Приватний підприємець Фещенко Володимир Борисович;ПП Фещенко В.Б.;08300, Україна, Київська область, м. Бориспіль, вул Київський шлях, 39, кв. 72;08300, Україна, Київська область, м. Бориспіль, вул Київський шлях, 39, кв. 72;2838410636;;;;;;;;;0;1063;1061;0;;;;"
    l_split = line.split(";")
    edrpou = l_split[EDRPOU]
    assert_equal "2838410636", edrpou
  end


  def test_arendator_edrpou_is_uridical
    line =  "194;54;2008-09-18 10:10:51.673000000;ПП „Бориспільавтогаз”;ПП „Бориспільавтогаз”;м. Бориспіль, вул. Київський шлях. 2/15;м. Бориспіль, вул. Київський шлях. 2/15;31295693 ;;;;;;;;;1;-1;-1;0;;;;"
    l_split = line.split(";")
    edrpou = l_split[EDRPOU]
    edrpou.strip!
    assert_equal 8, edrpou.length
  end

  def test_arendator_edrpou_is_fizikal
    line =  "452;54;2008-09-19 13:31:52.517000000;гр. Ничипорук Надія Пилипівна;гр. Ничипорук Надія Пилипівна;м. Бориспіль, вул. Київський шлях, 77, кв.19;м. Бориспіль, вул. Київський шлях, 77, кв.19;1376410989;;;;;;;;;0;-1;-1;0;;;;"
    l_split = line.split(";")
    edrpou = l_split[EDRPOU]
    assert_equal 10, edrpou.length
  end

  def test_arendator_edrpou_is_fizikal_method
    arendator = Arendator.new("452;54;2008-09-19 13:31:52.517000000;гр. Ничипорук Надія Пилипівна;гр. Ничипорук Надія Пилипівна;м. Бориспіль, вул. Київський шлях, 77, кв.19;м. Бориспіль, вул. Київський шлях, 77, кв.19;1376410989;;;;;;;;;0;-1;-1;0;;;;")
    assert arendator.is_fizikal?, "fizikal should be true"
  end

  def test_arendator_edrpou_is_uridical_method
    arendator = Arendator.new("194;54;2008-09-18 10:10:51.673000000;ПП „Бориспільавтогаз”;ПП „Бориспільавтогаз”;м. Бориспіль, вул. Київський шлях. 2/15;м. Бориспіль, вул. Київський шлях. 2/15;31295693 ;;;;;;;;;1;-1;-1;0;;;;")
    assert arendator.is_uridical?, "uridical should be true"
  end


  def test_arendator_edrpou_who_is_fiz
    arendator = Arendator.new("452;54;2008-09-19 13:31:52.517000000;гр. Ничипорук Надія Пилипівна;гр. Ничипорук Надія Пилипівна;м. Бориспіль, вул. Київський шлях, 77, кв.19;м. Бориспіль, вул. Київський шлях, 77, кв.19;1376410989;;;;;;;;;0;-1;-1;0;;;;")
    assert_equal "fiz", arendator.what_type
  end

  def test_arendator_edrpou_who_is_ur
    arendator = Arendator.new("194;54;2008-09-18 10:10:51.673000000;ПП „Бориспільавтогаз”;ПП „Бориспільавтогаз”;м. Бориспіль, вул. Київський шлях. 2/15;м. Бориспіль, вул. Київський шлях. 2/15;31295693 ;;;;;;;;;1;-1;-1;0;;;;")
    assert_equal "ur", arendator.what_type
  end


  def test_arendator_name_ur
    arendator = Arendator.new("194;54;2008-09-18 10:10:51.673000000;ПП „Бориспільавтогаз”;ПП „Бориспільавтогаз”;м. Бориспіль, вул. Київський шлях. 2/15;м. Бориспіль, вул. Київський шлях. 2/15;31295693 ;;;;;;;;;1;-1;-1;0;;;;")
    assert_equal "Бориспільавтогаз", arendator.name
  end

  def test_arendator_type_ur
    arendator = Arendator.new("194;54;2008-09-18 10:10:51.673000000;ПП „Бориспільавтогаз”;ПП „Бориспільавтогаз”;м. Бориспіль, вул. Київський шлях. 2/15;м. Бориспіль, вул. Київський шлях. 2/15;31295693 ;;;;;;;;;1;-1;-1;0;;;;")
    assert arendator.is_PP?
  end


  #def test_count_is_ten
  #  count = 10
  #  assert false, "Count should be 10"
  #end

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    # Do nothing
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.

  def teardown

  end

end