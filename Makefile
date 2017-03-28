default:
	elm make src/Main.elm --output is-this-baokaka.js

run: default
	open index.html
