
uploadFile = (evt) ->
  $('#file_input_id').trigger("click")
  evt.preventDefault()

uploadChange = (evt) ->
  file_data = $('#tft-1')
  file_day = $('#fday')
  file_month = $('#fmonth')

  $('#fic').css('display','none')
  $('#fic_true').css('display','block')
  $('#b_gotovo').css('display','block')

  file = evt.target.files
  fileName = file[0].name

  $('#fileR28Name').text(fileName)
  day = fileName.substr(4,2)
  month = fileName.substr(6,2)
  month_arr = ['','января','февраля','марта','апреля','мая','июня','июля','августа','сентября','октября','ноября','декабря']

  if month[0] is '0'
    month = month[1]

  month_s = month_arr[month]
  file_day.text(day)
  file_month.text(month_s)
  data_f = "2012-" + month + "-" + day
  file_data.val(data_f)


cancelUpload = (evt) ->
  $('#fic').css('display','block')
  $('#fic_true').css('display','none')
  $('#b_gotovo').css('display','none')


selectR28File = (evt) ->
  $(this).children('.download').css('opacity','1')
  $(this).addClass('select')
  console.log($(this))


unselectR28File = (evt) ->
  $(this).children('.download').css('opacity','0.3')
  $(this).removeClass('select')


test = (evt) ->
  alert 'f'


appVpfiles =

  test: =>
    alert 'foo'

  init: =>
    $('#upload_file_link').bind('click', uploadFile)
    $('#file_input_id').bind('change', uploadChange)
    $('#b_cancel_link').click(cancelUpload)
    $('.r28file').mouseenter(selectR28File)
    $('.r28file').mouseleave(unselectR28File)


jQuery ->
  appVpfiles.init()

