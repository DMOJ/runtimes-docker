TAG=latest

all: image-tier1

image-tier1:
	cd tier1 && docker build -t dmoj/runtimes-tier1:$(TAG) .

test: test-tier1

test-tier1:
	docker run --rm -v "`pwd`/test":/code dmoj/runtimes-tier1:$(TAG)
