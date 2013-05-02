Hapi = require 'hapi'
server = Hapi.createServer 'localhost', 8000
server.start ->
	console.log "Server started at: #{server.info?.uri}"
server.route 
	method: "*"
	path: "/status"
	handler: ->
		this.reply('ok')