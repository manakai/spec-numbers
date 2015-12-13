all: index.html

index.html: source.html
	curl -f -L -X POST --data-binary @$< https://misc-py.herokuapp.com/anolis > $@

## License: Public domain.
