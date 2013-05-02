Hapi = require 'hapi'
exports.createServer = ->
	server = Hapi.createServer 'localhost', 8000
	server.route 
		method: "*"
		path: "/status"
		handler: ->
			this.reply('ok')
	server

