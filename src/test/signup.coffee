Mocha = require 'mocha'
Server = require '../server'
Chai = require 'chai'
Sinon = require 'sinon'
Crypto = require 'crypto'
Chai.should()

createDbStub = ->
	db = {}
	collection = {}
	db.collection = Sinon.stub().yields undefined, collection
	return [db, collection]

describe "API", ->
	describe 'POST /signup', ->
		it 'should create the first user', (done)->
			hash = Crypto.createHash 'sha256' 
			hash.update 'password', 'utf8'
			expectedHashedPassword = hash.digest 'hex'

			[db, collection] = createDbStub()
			collection.insert = Sinon.stub().yields undefined, {_id:"John", password:expectedHashedPassword}

			server = Server.createServer({db:db})
			server.inject
				url: "/signup"
				payload: JSON.stringify({name: "John", password:"password"}) 
				method: "POST" ,
				(res)->
					res.statusCode.should.equal(200)
					collection.insert.callCount.should.equal(1)
					collection.insert.firstCall.args[0].should.eql {_id:"John", password:expectedHashedPassword}
					res.result.should.equal("ok")
					done()
		it 'does not allow more than one user with the same name', (done)->

			[db, collection] = createDbStub()
			collection.insert = Sinon.stub().yields {message:"dup", code:11000}, undefined

			server = Server.createServer({db:db})
			server.inject
				url: "/signup"
				payload: JSON.stringify({name: "John", password:"password"}) 
				method: "POST" ,
				(res)->
					res.statusCode.should.equal(409) #resource conflict
					collection.insert.callCount.should.equal(1)
					JSON.parse(res.result).should.eql reason:"user already exist"
					done()
		it 'does not allow the password to be less than 8 charachters', (done) ->
			[db, collection] = createDbStub()
			collection.insert = Sinon.stub().yields undefined, {}

			server = Server.createServer({db:db})
			server.inject
				url: "/signup"
				payload: JSON.stringify({name: "John", password:"passwor"}) 
				method: "POST" ,
				(res)->
					collection.insert.callCount.should.equal(0)
					res.statusCode.should.equal(400)
					done()
