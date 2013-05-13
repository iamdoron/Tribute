Hapi = require 'hapi'

exports.createServer = (options)->
	server = Hapi.createServer '0.0.0.0', 8000, {cors:true, tls:options.tls}
	server.route 
		method: "*"
		path: "/status"
		config:
			handler: ->
				this.reply('ok')
	server.route 
		method: "POST"
		path: "/signup" 
		config:
			handler: (req) ->
				this.reply(req.payload)

	server

