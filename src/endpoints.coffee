Hapi = require 'hapi'
Login = require './login'

exports.generateCreateUserConfig = Login.generateCreateUserConfig

exports.generatePatchUserConfig = (options) ->
	validate:
		path:
			name: Hapi.types.String().required()
		payload:
			about: Hapi.types.String().required() 
	handler: (request)->
		options.db.collection 'users', (err, collection)->
			collection.update {_id:request.params.name} , {$set:request.payload}, (err, count) ->
				request.reply('ok')



