all:
	npm install
	./node_modules/.bin/bower install
	./node_modules/.bin/grunt  release
