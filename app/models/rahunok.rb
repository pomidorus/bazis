class Rahunok < ActiveRecord::Base
  attr_accessible :code, :number
  belongs_to :vipiska_file

  def self.find_rahunok_id(id, acc1)
    w = Rahunok.where("number = :number AND vipiska_file_id = :vpid", :number => acc1, :vpid => id).first
    w.id
  end


end
