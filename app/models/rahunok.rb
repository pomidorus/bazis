class Rahunok < ActiveRecord::Base
  attr_accessible :code, :number
  belongs_to :vipiska_file

  def self.find_rahunok_id(id, acc1)
    w = where("number = :number AND vipiska_file_id = :vpid", :number => acc1, :vpid => id).first
    w.id
  end

  def self.find_arenda(id)
    where("vipiska_file_id = :id AND (code = '13050200' OR code = '13050500')", :id => id)
  end

  def self.find_nalog(id)
    where("vipiska_file_id = :id AND (code = '13050100' OR code = '13050300')", :id => id)
  end


end
