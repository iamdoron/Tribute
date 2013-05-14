Hapi = require 'hapi'
Login = require './login'

exports.generateCreateUserConfig = Login.generateCreateUserConfig

exports.generatePatchUserConfig = (options) ->
	auth: 'simple'
	validate:
		path:
			name: Hapi.types.String().required()
		payload:
			about: Hapi.types.String().required() 
	handler: (request)->
		if request.auth.credentials.id != request.params.name
			request.reply Hapi.error.forbidden('only the same user can update its profile')
			return
		options.db.collection 'users', (err, collection)->
			collection.update {_id:request.params.name} , {$set:request.payload}, (err, count) ->
				request.reply('ok')



