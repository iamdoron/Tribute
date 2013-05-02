Mocha = require 'mocha'
Server = require '../server'
Chai = require 'chai'
Chai.should()

describe "application", ->
	describe "API", ->
		describe "GET /status", ->
			it "should return reply with ok", (done)->
				Server.createServer().inject  
					url: "/status" 
					method: "GET" ,
					(res)->
						res.statusCode.should.equal(200)
						console.log res.result
						res.result.should.equal("ok")
						done()
