server = (require "./server").createServer()

server.start ->
	console.log "Server started at: #{server.info?.uri}"