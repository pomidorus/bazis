class Role < ActiveRecord::Base

  has_many :user

  attr_accessible :desc, :name
end
