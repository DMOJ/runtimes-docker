TAG ?= latest

.PHONY: all image-tier1 image-tier2 image-tier3 clean test-tier1 test-tier2 test-tier3

all: image-tier1 image-tier2 image-tier3

image-tier1:
	cd tier1 && docker build -t dmoj/runtimes-tier1 -t dmoj/runtimes-tier1:$(TAG) -t ghcr.io/dmoj/runtimes-tier1:$(TAG) .

image-tier2: image-tier1
	cd tier2 && docker build -t dmoj/runtimes-tier2 -t dmoj/runtimes-tier2:$(TAG) -t ghcr.io/dmoj/runtimes-tier2:$(TAG) .

image-tier3: image-tier2
	cd tier3 && docker build -t dmoj/runtimes-tier3 -t dmoj/runtimes-tier3:$(TAG) -t ghcr.io/dmoj/runtimes-tier3:$(TAG) .

clean:
	-docker rmi dmoj/runtimes-tier3 dmoj/runtimes-tier3:$(TAG) ghcr.io/dmoj/runtimes-tier3:$(TAG)
	-docker rmi dmoj/runtimes-tier2 dmoj/runtimes-tier2:$(TAG) ghcr.io/dmoj/runtimes-tier2:$(TAG)
	-docker rmi dmoj/runtimes-tier1 dmoj/runtimes-tier1:$(TAG) ghcr.io/dmoj/runtimes-tier1:$(TAG)
	docker builder prune -f

test: test-tier1 test-tier2 test-tier3

test-tier1:
	docker run --rm -v "`pwd`/test":/code --cap-add=SYS_PTRACE dmoj/runtimes-tier1

test-tier2:
	docker run --rm -v "`pwd`/test":/code --cap-add=SYS_PTRACE dmoj/runtimes-tier2

test-tier3:
	docker run --rm -v "`pwd`/test-tier3":/code --cap-add=SYS_PTRACE dmoj/runtimes-tier3
