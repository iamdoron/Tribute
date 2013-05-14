Mocha = require 'mocha'
Server = require '../server'
Chai = require 'chai'
Sinon = require 'sinon'
MongoTestHelpers = require('./mongoTestHelpers')

Chai.should()

createDbStub = MongoTestHelpers.createDbStub


basicHeader = (username, password) ->
	'Basic ' + (new Buffer(username + ':' + password, 'utf8')).toString('base64');

describe "API", ->
	describe "PATCH /users/{name}", ->
		it 'should update the new "about" text', (done)->
			injection = 
				method: 'PATCH'
				url: '/users/john'
				payload:
					JSON.stringify about: "John Doe is a darn nice guy"
				headers: 
					authorization: basicHeader('john', 'password') 

			[db, collection] = createDbStub()
			collection.update = Sinon.stub().yields undefined, 1

			server = Server.createServer({db:db, bcryptRounds: 4})
			server.inject injection, (res)->
				res.statusCode.should.equal(200)

				collection.update.callCount.should.equal(1)
				collection.update.firstCall.args[0].should.eql({_id:'john'})
				collection.update.firstCall.args[1].should.eql({$set:{about:"John Doe is a darn nice guy"}})
				done()

	describe "GET /status", ->
		it "should return reply with ok", (done)->
			server = Server.createServer({bcryptRounds: 4})
			server.inject  
				url: "/status" 
				method: "GET" ,
				(res)->
					res.statusCode.should.equal(200)
					res.result.should.equal("ok")
					done()
