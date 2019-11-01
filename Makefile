TAG ?= latest

.PHONY: image-tier1 image-tier2 image-tier3 test-tier1 test-tier2 test-tier3

all: image-tier1 image-tier2 image-tier3

image-tier1:
	cd tier1 && docker build -t dmoj/runtimes-tier1:$(TAG) .

image-tier2: image-tier1
	cd tier2 && docker build -t dmoj/runtimes-tier2:$(TAG) .

image-tier3: image-tier2
	cd tier3 && docker build -t dmoj/runtimes-tier3:$(TAG) .

test: test-tier1 test-tier2 test-tier3

test-tier1:
	docker run --rm -v "`pwd`/test":/code dmoj/runtimes-tier1:$(TAG) --cap-add=SYS_PTRACE

test-tier2:
	docker run --rm -v "`pwd`/test":/code dmoj/runtimes-tier2:$(TAG) --cap-add=SYS_PTRACE

test-tier3:
	docker run --rm -v "`pwd`/test":/code dmoj/runtimes-tier3:$(TAG) --cap-add=SYS_PTRACE
