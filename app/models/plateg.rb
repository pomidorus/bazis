#encoding: utf-8

class Plateg < ActiveRecord::Base
  attr_accessible :acc1, :acc2, :bank, :comment, :platnik, :platnik_c, :summa
  belongs_to :rahunok

  #Находим все платежи по файлу выписки и коду
  def self.find_all_by_vipiska_file_id_and_rahunok_code(id, code)
    rahunok = Rahunok.where("vipiska_file_id = :id AND code = :code", :id => id, :code => code)
    plg = []
    rahunok.each do |r|
      plategi = Plateg.find_all_by_rahunok_id r.id
      plategi.each do |p|
        plg << p
      end
    end
    return plg
  end

  #Находим сумму платежей
  def self.summa_plateg(plategi)
    money = []
    plategi.each do |p|
      money << p.summa.to_f
    end
    return money.sum
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

end
