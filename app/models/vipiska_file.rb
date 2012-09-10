# encoding: utf-8

class VipiskaFile < ActiveRecord::Base
  attr_accessible :download_count, :file_name, :upload_at

  def date_ukr
    y = upload_at.year
    m = upload_at.month
    m_ukr = ['sicen','dod','sicen','sicen','sicen','sicen','sicen','sicen','sicen','sicen','sicen','sicen']
    m_rus = ['','январь','февраль','март','апрель','май','июнь','июль','август','сентябрь','октябрь','ноябрь','декабрь']
    d = upload_at.day
    return "#{d} #{m_rus[m]}"
  end
end
