$ = require 'jquery'
$ ->
  url = 'https://salesforcelogin.github.io'
  $marketing = $('#marketing')
  $('#marketing').on 'load', ->
    $('#marketing').attr('src', url) if $marketing.attr('src') != url
