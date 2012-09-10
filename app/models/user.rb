# encoding: utf-8

class User < ActiveRecord::Base
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:login]

  belongs_to :role

  attr_accessor :login
  attr_accessible :login, :email, :password, :password_confirmation, :remember_me, :username,
                  :name, :surname, :photo, :enabled, :telephone, :role_id

  def self.find_first_by_auth_conditions(warden_conditions)
     conditions = warden_conditions.dup
     if login = conditions.delete(:login)
       where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
     else
       where(conditions).first
     end
  end

  def full_name
    "#{name} #{surname}"
  end

  def obr_name
    "#{surname} #{name}"
  end

  def role_name
    role.name
  end

  def secretar?
    if role_name == "Секретарь" then
      true
    else
      false
    end
  end

end
