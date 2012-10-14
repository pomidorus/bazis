
window.VpFile = class VpFile

  constructor: (evt) ->
    files = evt.target.files
    @name = @parseData files[0].name

  parseData: (fileName) ->
    fileName

  extention: ->
    name = @name


#    @day = fileName.substr(4,2)
#    @month = fileName.substr(6,2)
#    month_arr = ['','января','февраля','марта','апреля','мая','июня','июля','августа','сентября','октября','ноября','декабря']
#
#    if month[0] is '0'
#      month = month[1]
#
#    month_s = month_arr[month]
#    data_f = "2012-" + month + "-" + day
