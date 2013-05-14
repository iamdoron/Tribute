Sinon = require 'sinon'

exports.createDbStub = ->
	db = {}
	collection = {}
	db.collection = Sinon.stub().yields undefined, collection
	return [db, collection]