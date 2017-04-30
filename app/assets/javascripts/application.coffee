## Plugins
#= require jquery
#= require jquery_ujs
#= require jquery.remotipart
#= require bootstrap-sprockets
#= require turbolinks
#= require toastr

## Custom
$ ->
  ## Initialize Bootstrap popover
  $('[data-toggle="popover"]').popover('show')

  ## Iinitialize select text
  range = document.createRange()
  selection = window.getSelection()
  range.selectNodeContents document.getElementById('short-url')
  selection.removeAllRanges()
  selection.addRange range