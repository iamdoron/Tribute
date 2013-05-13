Hapi = require 'hapi'
Hoek = require 'hoek'

exports.createServer = (options)->
	serverSettings = Hoek.applyToDefaults({cors: true}, options?.server);
	server = Hapi.createServer '0.0.0.0', 8000, serverSettings
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
				newUser = req.payload
				newUser._id = req.payload.name
				options.db.collection 'users', (err, collection) ->
					collection.insert newUser, (err, insertedUser)->


	server

