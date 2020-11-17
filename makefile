rebuild: clean build

build:
	mdbook build -d docs

clean:
	rm -rf docs
