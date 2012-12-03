#encoding: utf-8

class Plateg < ActiveRecord::Base
  attr_accessible :acc1, :acc2, :bank, :comment, :platnik, :platnik_c, :summa
  belongs_to :rahunok


  def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |plateg|
        csv << plateg.attributes.values_at(*column_names)
      end
    end
  end

  #Находим все платежи по файлу выписки и коду
  def self.find_all_by_vipiska_file_id_and_rahunok_code(id, code)

    #rahunok = Rahunok.where("vipiska_file_id = :id AND code = :code", :id => id, :code => code)
    rahunok = Rahunok.find_arenda(id) if code == "1"
    rahunok = Rahunok.find_nalog(id) if code == "2"

    plg = []
    rahunok.each do |r|
      plategi = Plateg.find_all_by_rahunok_id r.id
      plategi.each do |p|
        plg << p
      end
    end
    plg.sort_by! {|x| x.summa.to_f}
    plg.reverse!
    return plg
  end

  #Находим сумму платежей
  def self.summa_plateg(plategi)
    money = []
    plategi.each do |p|
      money << p.summa.to_f
    end
    return string_to_money(money.sum)
  end

  #Находим имя плательщика по ЕДРПОУ
  def platnik_name
    edrpou = platnik
    person = Person.find_by_edrpou edrpou
    if !person.nil?
      person.name
    else
      "Нет в базе"
    end
  end

  def platnik_id
    edrpou = platnik
    person = Person.find_by_edrpou edrpou
    if !person.nil?
      return person.id
    else
      return nil
    end
  end


  def self.string_to_money(money)
    s = money.round(2)
    kop = (s % 1).round(2)
    kop_r = ((s % 1).round(2)*100).round(0)
    grn = (s - kop).round(0)
    grn_s = grn.to_s
    grn_s = grn.to_s.insert -4, " " if grn_s.length > 3
    grn.i
    if kop_r == 0.0
      "#{grn_s} грн"
    else
      "#{grn_s} грн #{kop_r} коп"
    end

  end

  def summa_to_text
    Plateg.string_to_money(summa.to_f)
  end

end
