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

  $('button', $form).removeAttr('disabled')
