Mocha = require 'mocha'
Server = require '../server'
Chai = require 'chai'
Sinon = require 'sinon'
Crypto = require 'crypto'
Chai.should()

describe "API", ->
	describe "GET /status", ->
		it "should return reply with ok", (done)->
			Server.createServer().inject  
				url: "/status" 
				method: "GET" ,
				(res)->
					res.statusCode.should.equal(200)
					res.result.should.equal("ok")
					done()
