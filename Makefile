REPORTER ?= dot
build: 
	@./node_modules/coffee-script/bin/coffee -o ./lib -c ./src
test: build
	@cd lib;\
	../node_modules/.bin/mocha \
		--reporter $(REPORTER) 
watch: 
	@./node_modules/coffee-script/bin/coffee -o ./lib -cw ./src
test-watch: 
	@cd lib;\
	../node_modules/.bin/mocha \
		--reporter $(REPORTER) --growl  --watch 
clean: 
	rm -r -f lib

.PHONY: build test clean watch test-watch