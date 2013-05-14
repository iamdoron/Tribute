Hapi = require 'hapi'
Hoek = require 'hoek'
Endpoints = require './endpoints'

exports.createServer = (options)->
	defaults = 
		bcryptRounds: 12
		server:
			cors: true
	
	settings = defaults
	settings = Hoek.applyToDefaults(defaults, options) if options?
	settings.db = options.db if options?.db?

	server = Hapi.createServer '0.0.0.0', 8000, settings.server

	server.route 
		method: "GET"
		path: "/status"
		config:
			handler: ->
				this.reply('ok')

	server.route 
		method: "POST"
		path: "/signup" 
		config: Endpoints.generateCreateUserConfig(settings)

	server

