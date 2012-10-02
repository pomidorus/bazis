
uploadFile = (evt) ->
  $('#file_input_id').trigger("click")
  console.log('click')
  evt.preventDefault()

uploadChange = (evt) ->
  file_data = $('#tft-1')
  file_day = $('#fday')
  file_month = $('#fmonth')


  $('#fic').css('display','none')
  $('#fic_true').css('display','block')
  $('#b_gotovo').css('display','block')

  file = evt.target.files
  $('#fileR28Name').text(file[0].fileName)
  fn = file[0].fileName
  day = fn.substr(4,2)
  month = fn.substr(6,2)
  month_arr = ['','января','февраля','марта','апреля','мая','июня','июля','августа','сентября','октября','ноября','декабря']

  if month[0] is '0'
    month = month[1]

  month_s = month_arr[month]
  console.log(month_s)
  console.log(month)
  file_day.text(day)
  file_month.text(month_s)

  data_f = "2012-" + month + "-" + day
  console.log(data_f)

  file_data.val(data_f)
  console.log(file_data)


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

jQuery ->
  $('#upload_file_link').bind('click', uploadFile)
  $('#file_input_id').bind('change', uploadChange)
  $('#b_cancel_link').click(cancelUpload)
  $('.r28file').mouseenter(selectR28File)
  $('.r28file').mouseleave(unselectR28File)


#  $('#file_input_id').click(test)
#  $('input[name$="file_r28"]').bind('change',uploadFileR28)
#  $('#upload_vipiska').bind('click',uploadVipiskaClick)
#  $('#cancel_upload').bind('click',cancelUploadClick)

#class Arbiter
#  constructor: ->
#  gav: ->
#    alert 'gav'
#
#uploadFileR28 = (evt) ->
#  file = evt.target.files
#  alert file[0].fileName
#
#uploadVipiskaClick = (evt) ->
#  $(this).addClass('disapear')
#  $('#uploadfile_block').removeClass('dis')
#
#cancelUploadClick = (evt) ->
#  $('#uploadfile_block').addClass('dis')
#  $('#upload_vipiska').removeClass('disapear')
