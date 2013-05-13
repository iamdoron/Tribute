Fs = require('fs');

tls =
	key: (Fs.readFileSync 'tls/key.pem').toString()
	cert: (Fs.readFileSync 'tls/cert.pem').toString()
	
server = (require "./server").createServer 
	tls: tls

server.start ->
	console.log "Server started at: #{server.settings?.uri}"
