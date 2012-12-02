# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

showAlert = (evt) ->
  alert 'fuck you'

arendators =
  init: =>
    btn_spysok = $('#btn_spysok')

    btn_spysok.bind('click',showAlert)

jQuery ->
  arendators.init()
