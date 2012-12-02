#encoding: utf-8

class ArendatorTypes < ActiveRecord::Base
  attr_accessible :description, :name
  validates_presence_of :description, :name
  validates_length_of :name, :maximum => 16

  PP = ArendatorTypes.find_by_name("ПП")

end
