Crypto = require 'crypto'
Hapi = require 'hapi'

exports.createUser = 
	validate:
		payload:
			name: Hapi.types.String().rename('_id', {deleteOrig:true})
			password: Hapi.types.String()

	handler: (req) ->
		hash = Crypto.createHash 'sha256' 
		hash.update 'password', 'utf8'
		hashedPassword = hash.digest 'hex'
		newUser = req.payload
		newUser.password = hashedPassword
		exports.options.db.collection 'users', (err, collection) ->
			collection.insert newUser, (err, insertedUser)->
				req.reply('ok')