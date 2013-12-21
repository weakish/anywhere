#!/usr/bin/env lsc

connect = require('connect')
cwd = process.cwd()
exec = require('child_process').exec
spawn = require('child_process').spawn
util = require('util')


openURL = (url) ->
    switch process.platform
      | 'darwin' => exec('open' + url)
      | 'win32' => exec('start' + url)
      | otherwise => spawn('xdg-open', [url])


app = connect!
app.use((req, res, next) ->
  res.setHeader('Access-Control-Allow-Origin', '*')
  next()
)
app.use(connect.static(cwd))
app.use(connect.directory(cwd))
port = process.argv[2] or 8080
app.listen(port, ->
  url = 'http://localhost:' + port
  util.puts('Running at ' + url)
  openURL(url)
)

