all: index.html

index.html: source.html chars.pl
	mkdir -p local
	perl chars.pl > local/chars.html
	cat source.html | perl -n -e 's{<!--CHARS-->}{open $$chars, "<", "local/chars.html" or die $$!; local $$/ = undef; scalar <$$chars>}ge; print' > local/source.html
	docker run -i quay.io/wakaba/anolis < local/source.html > $@

## License: Public domain.
