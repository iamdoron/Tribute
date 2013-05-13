Fs = require 'fs'
Mongodb = require 'mongodb' 
server = new Mongodb.Server("127.0.0.1", 27017)

(new Mongodb.Db 'test', server, {w:'majority'}).open (error, client) ->
	throw error if (error) 

	tls =
		key: (Fs.readFileSync 'tls/key.pem').toString()
		cert: (Fs.readFileSync 'tls/cert.pem').toString()
		
	server = (require "./server").createServer
		server: 
			tls: tls
		db: client
	
	server.pack.require 'lout', ->

	server.start ->
		console.log "Server started at: #{server.settings?.uri}"
