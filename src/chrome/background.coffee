SalesforceLogin = require '../salesforcelogin.coffee'
chrome.browserAction.onClicked.addListener ->
  chrome.tabs.create
    url: 'https://salesforcelogin.github.io'
chrome.runtime.onMessageExternal.addListener (message, sender, callback)->
  SalesforceLogin.login(message.payload, callback) if message.action == 'login'
  return true
