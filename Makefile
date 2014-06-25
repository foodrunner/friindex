PATH := ./node_modules/.bin:${PATH}

init:
	npm install


clean:
	rm -rf lib/ 

build:
	coffee -o lib/ src/

test:
	jasmine-node --coffee specs

dist: 
	clean init build test

publish: dist
	npm publish