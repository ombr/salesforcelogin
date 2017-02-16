superagent = require 'superagent'
$ = require 'jquery'
SalesforceLogin = {}
SalesforceLogin.login = (options, callback)->
  superagent
    .post(@soap_login_url(options.env))
    .send(@payload(options.username, options.password))
    .set('Content-Type', 'text/xml; charset=UTF-8')
    .set('SOAPAction', 'login')
    .end (err, res)->
      callback(SalesforceLogin.parse_response(err, res))
SalesforceLogin.soap_login_url = (env)->
  "https://#{env}.salesforce.com/services/Soap/u/39.0"
SalesforceLogin.payload = (username, password)->
  '<?xml version="1.0" encoding="utf-8" ?>
  <env:Envelope xmlns:xsd="http://www.w3.org/2001/XMLSchema" \
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" \
  xmlns:env="http://schemas.xmlsoap.org/soap/envelope/">
    <env:Body>
      <n1:login xmlns:n1="urn:partner.soap.sforce.com">
        <n1:username>' + username + '</n1:username>
        <n1:password>' + password + '</n1:password>
      </n1:login>
    </env:Body>
  </env:Envelope>'
SalesforceLogin.parse_response = (err, res)->
  if err || !res.ok?
    try
      return {
        error: true,
        message: $(res.text).find('faultstring').text()
      }
    catch
      return { error: true, message: err }
  else
    $res = $(res.text)
    server_url = $res.find('serverUrl').text().split('/services')[0]
    session_id = $res.find('sessionId').text()
    {
      error: false
      session_id: session_id,
      server_url: server_url,
      login_url: "#{server_url}/secur/frontdoor.jsp?sid=#{session_id}"
    }
module.exports = SalesforceLogin
