Mocha = require 'mocha'
Server = require '../server'
Chai = require 'chai'
Sinon = require 'sinon'
Chai.should()

describe "application", ->
	describe "API", ->
		describe 'POST /signup', ->
			it 'should create a new user', ->
				db = {}
				collection = {}
				db.collection = Sinon.stub().yields [undefined, collection]
				collection.insert = Sinon.stub().yields [undefined, {_id:"John", name: "John", password:"password"}]

				server = Server.createServer({db:db})
				server.inject
					url: "/signup"
					payload: JSON.stringify({name: "John", password:"password"}) 
					method: "POST" ,
					(res)->
						res.statusCode.should.equal(200)
						collection.insert.callCount.should.equal(1)
						collection.insert.calledWith({_id:"John", name: "John", password:"password"}).should.be.true
						res.result.should.equal("ok")
						done()

		describe "GET /status", ->
			it "should return reply with ok", (done)->
				Server.createServer().inject  
					url: "/status" 
					method: "GET" ,
					(res)->
						res.statusCode.should.equal(200)
						res.result.should.equal("ok")
						done()
