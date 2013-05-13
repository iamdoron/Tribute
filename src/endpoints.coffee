Crypto = require 'crypto'


exports.createUser = 
	handler: (req) ->
		hash = Crypto.createHash 'sha256' 
		hash.update 'password', 'utf8'
		hashedPassword = hash.digest 'hex'
		newUser = req.payload
		newUser.password = hashedPassword
		newUser._id = req.payload.name
		exports.options.db.collection 'users', (err, collection) ->
			collection.insert newUser, (err, insertedUser)->
				req.reply('ok')