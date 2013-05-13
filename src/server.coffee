Hapi = require 'hapi'
Hoek = require 'hoek'
Endpoints = require './endpoints'

exports.createServer = (options)->
	Endpoints.options = options
	serverSettings = Hoek.applyToDefaults({cors: true}, options?.server);
	server = Hapi.createServer '0.0.0.0', 8000, serverSettings
	server.route 
		method: "GET"
		path: "/status"
		config:
			handler: ->
				this.reply('ok')

	server.route 
		method: "POST"
		path: "/signup" 
		config: Endpoints.createUser

	server

