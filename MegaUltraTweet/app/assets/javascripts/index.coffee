# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#= require jquery
#= require wiselinks

# initialize wiselinks
$(document).ready ->
  window.wiselinks = new Wiselinks('#content')

# toggle loading animation on and off
$(document).on 'page:loading', ->
  $('.se-pre-con').fadeIn 'fast'
$(document).on 'page:always', ->
  $('.se-pre-con').fadeOut 'fast'
$(document).ready ->
  $('.se-pre-con').fadeOut 'slow'

#$(document).ready ->
#  $('.search-field').focusin ->
#    $('.search-button').css({'background': '#1A92CF', 'color': '#fff'})

$(document).ready ->
  $('.search-field').focusin ->
    $('.search-button').toggleClass('js-search-button-focus')
  $('.search-field').focusout ->
    $('.search-button').toggleClass('js-search-button-focus')

#$(document).ready ->
#  $('.search-field').focusout ->
#    $('.search-button').css({'background': '#fff', 'color': '#1A92CF'})

