output_dir = build/
output_filename = is-this-baokaka.js
output_path = $(output_dir)$(output_filename)

default: build

minimize:
	uglifyjs $(output_path) -c -o $(output_path)

build:
	elm make --yes src/Main.elm --output $(output_path)

production: build minimize

.PHONY: build minimize
