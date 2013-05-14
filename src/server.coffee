Hapi = require 'hapi'
Hoek = require 'hoek'
Endpoints = require './endpoints'

exports.createServer = (options)->
	defaults = 
		bcryptRounds: 12
		server:
			cors: true
	
	Endpoints.options = defaults
	Endpoints.options = Hoek.applyToDefaults(defaults, options) if options?
	Endpoints.options.db = options.db if options?.db?

	server = Hapi.createServer '0.0.0.0', 8000, Endpoints.options.server

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

