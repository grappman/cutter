#= require jquery
#= require jquery_ujs
#= require bootstrap-sprockets
#= require turbolinks


$('.urls.shortened').ready ->
  $('#short-url').popover 'show'
  $('body').click ->
    $('#short-url').popover 'hide'
    return
  range = document.createRange()
  selection = window.getSelection()
  range.selectNodeContents document.getElementById('short-url')
  selection.removeAllRanges()
  selection.addRange range
  return
$('.urls.index').ready ->
  $('#url_original_url').attr 'size', $('#url_original_url').attr('placeholder').length
  return

# ---
# generated by js2coffee 2.2.0