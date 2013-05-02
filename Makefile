REPORTER ?= dot
build: 
	@./node_modules/coffee-script/bin/coffee -o ./lib -c ./src
test: build
	@cd lib;\
	../node_modules/.bin/mocha \
		--reporter $(REPORTER) 
clean: 
	rm -r -f lib

.PHONY: build test clean