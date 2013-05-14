Hapi = require 'hapi'
Hoek = require 'hoek'
Endpoints = require './endpoints'
Login = require './login'

exports.createServer = (options)->
	defaults = 
		bcryptRounds: 12
		server:
			cors: true
	
	settings = defaults
	settings = Hoek.applyToDefaults(defaults, options) if options?
	settings.db = options.db if options?.db?

	server = Hapi.createServer '0.0.0.0', 8000, settings.server

	server.auth 'simple', 
    	scheme: 'basic',
    	validateFunc: Login.generateValidate(settings)
	
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

	server.route 
		method: "PATCH"
		path: "/users/{name}" 
		config: Endpoints.generatePatchUserConfig(settings)

	server

