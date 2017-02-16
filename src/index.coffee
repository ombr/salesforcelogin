`import css from './index.sass';`
`import $ from '../node_modules/jquery/dist/jquery';`
window.$ = $
$ ->
  $form = $('#login-form')
  $form.on 'submit', (e)->
    e.preventDefault()
    payload =
      username : $('#username').val()
      password: $('#password').val()
      env: 'login'
    if chrome? and chrome.runtime? and chrome.runtime.sendMessage?
      chrome.runtime.sendMessage(
        'ijdkpfdpocgbpempblmkfppepmcbhhfa',
        {
          'action': 'login',
          payload: payload
        },
        (result)->
          console.log 'response !', result
      )
  $('button', $form).removeAttr('disabled')
