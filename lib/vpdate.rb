#encoding: utf-8

#extend Date class

class Date

  MONTHNAMESRU = ['','января','февраля','марта','апреля','мая','июня','июля','августа','сентября','октября','ноября','декабря']

  def month_to_word
    MONTHNAMESRU[month]
  end

end


