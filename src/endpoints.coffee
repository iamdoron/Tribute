Crypto = require 'crypto'
Hapi = require 'hapi'

dupKeyError = 11000

exports.createUser = 
	validate:
		payload:
			name: Hapi.types.String().rename('_id', {deleteOrig:true})
			password: Hapi.types.String().min(8).description('8 characters or longer')

	handler: (req) ->
		hash = Crypto.createHash 'sha256' 
		hash.update 'password', 'utf8'
		hashedPassword = hash.digest 'hex'
		newUser = req.payload
		newUser.password = hashedPassword
		exports.options.db.collection 'users', (err, collection) ->
			collection.insert newUser, (err, insertedUser)->
				if (err?.code is dupKeyError)
					req.reply Hapi.error.passThrough 409, '{"reason":"user already exist"}', 'application/json'
					return
				req.reply('ok')