Bcrypt = require 'bcrypt'
Hapi = require 'hapi'

dupKeyError = 11000

exports.generateCreateUserConfig = (options) ->
	return 	{
			validate:
				payload:
					name: Hapi.types.String().rename('_id', {deleteOrig:true})
					password: Hapi.types.String().min(8).description('8 characters or longer')

			handler: (req) ->
				newUser = req.payload
				Bcrypt.hash newUser.password, options.bcryptRounds, (err, hashedPassword) ->
					newUser.password = hashedPassword
					options.db.collection 'users', (err, collection) ->
						collection.insert newUser, (err, insertedUser)->
							if (err?.code is dupKeyError)
								req.reply Hapi.error.passThrough 409, '{"reason":"user already exist"}', 'application/json'
								return
							req.reply('ok')
			}