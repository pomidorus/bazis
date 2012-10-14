class Rahunok < ActiveRecord::Base
  attr_accessible :code, :number
  belongs_to :vipiska_file
end
