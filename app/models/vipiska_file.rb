# encoding: utf-8

class VipiskaFile < ActiveRecord::Base
  attr_accessible :download_count, :file_name, :upload_at, :file_size, :file_for_data, :files_count_in

  M_RUS_SHORT = ['','янв','фев','мар','апр','май','июн','июл','авг','сен','окт','ноя','дек']

  def month_short
    M_RUS_SHORT[file_for_data.month]
  end

  def year
    "#{file_for_data.year}"
  end

  def day
    "#{file_for_data.day}"
  end

  def date_ukr
    y = upload_at.year
    m = upload_at.month
    m_ukr = ['sicen','dod','sicen','sicen','sicen','sicen','sicen','sicen','sicen','sicen','sicen','sicen']
    m_rus = ['','январь','февраль','март','апрель','май','июнь','июль','август','сентябрь','октябрь','ноябрь','декабрь']
    d = upload_at.day
    return "#{d} #{m_rus[m]}"
  end

  def file_ext
    file_name[-3,3].downcase
  end

  def file_name_ex
    s = file_name.split('.')
    return s[0]
  end

  def file_upload_data
    "#{upload_at.day} #{upload_at.month_to_word} #{upload_at.year}"
  end

  def file_upload_data_small
    "#{upload_at.day}.#{upload_at.month}.#{upload_at.year}"
  end

  def file_data
    if !file_for_data.nil?
      "#{file_for_data.day} #{file_for_data.month_to_word} #{file_for_data.year}"
    elsif
      ""
    end
  end

  def file_data_small
    "#{file_for_data.day}.#{file_for_data.month}.#{file_for_data.year}"
  end

  def self.today_vp
    VipiskaFile.find_all_by_upload_at Date.today, :order => "created_at desc"
  end

  def self.last_vp(_limit)
    VipiskaFile.where("upload_at < :date", :date => Date.today).order("created_at desc").limit(_limit)
  end

end


