Hapi = require 'hapi'

exports.createServer = (tls)->
	server = Hapi.createServer '0.0.0.0', 8000, {cors:true, tls:tls}
	server.route 
		method: "*"
		path: "/status"
		handler: ->
			this.reply('ok')
	server

