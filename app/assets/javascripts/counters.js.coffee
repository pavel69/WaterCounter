# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#$ ->
#  $(".btn-block").hide()
#
#  $('.overlay').hover(
#    -> $(this).find('.btn-block').fadeIn(250)
#    -> $(this).find('.btn-block').fadeOut(250)
#  )


ready = ->

  $('[data-behaviour~=datepicker]').datepicker({format: 'dd.mm.yyyy', language: 'ru'});

#  $(".btn-block").hide()
#
#  $('.overlay').hover(
#    -> $(this).find('.btn-block').fadeIn(250)
#    -> $(this).find('.btn-block').fadeOut(250)
#  )


  $('#counters_table:first').each ->
    $.ajax(url: "/counters/table")

  #for x in $("a[data-remote]")
  #  alert x.href
  #a['data-remote']

  #$.ajax(url: "/counters/test")


$(document).ready(ready)
$(document).on('page:load', ready)