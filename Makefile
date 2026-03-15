TAG ?= latest

.PHONY: all image-tier1 image-tier2 image-tier3 clean test-tier1 test-tier2 test-tier3

all: image-tier1 image-tier2 image-tier3

image-tier1:
	cd tier1 && docker build -t dmoj/runtimes-tier1 -t dmoj/runtimes-tier1:$(TAG) -t ghcr.io/dmoj/runtimes-tier1:$(TAG) .

image-tier2: image-tier1
	cd tier2 && docker build -t dmoj/runtimes-tier2 -t dmoj/runtimes-tier2:$(TAG) -t ghcr.io/dmoj/runtimes-tier2:$(TAG) \
	    --build-arg SCALA_ZIP_URL="$(shell ./github-curl https://api.github.com/repos/scala/scala3/releases | jq -r "[.[] | select(.prerelease | not) | .assets | flatten | .[] | select((.name | startswith(\"scala3-\")) and (.name | endswith(\"$(shell arch)-pc-linux.tar.gz\"))) | .browser_download_url][0]")" \
		.

image-tier3: image-tier2
	cd tier3 && docker build -t dmoj/runtimes-tier3 -t dmoj/runtimes-tier3:$(TAG) -t ghcr.io/dmoj/runtimes-tier3:$(TAG) \
	    --build-arg KOTLIN_ZIP_URL="$(shell ./github-curl https://api.github.com/repos/JetBrains/kotlin/releases | jq -r '[.[] | select(.prerelease | not) | .assets | flatten | .[] | select((.name | startswith("kotlin-compiler")) and (.name | endswith(".zip"))) | .browser_download_url][0]')" \
	    --build-arg LEAN4_ZIP_URL="$(shell ./github-curl https://api.github.com/repos/leanprover/lean4/releases | jq -r '[.[] | select(.prerelease | not) | .assets | flatten | .[] | select((.name | startswith("lean-")) and (.name | endswith("-linux.zip"))) | .browser_download_url][0]')" \
	    .

clean:
	-docker rmi dmoj/runtimes-tier3 dmoj/runtimes-tier3:$(TAG) ghcr.io/dmoj/runtimes-tier3:$(TAG)
	-docker rmi dmoj/runtimes-tier2 dmoj/runtimes-tier2:$(TAG) ghcr.io/dmoj/runtimes-tier2:$(TAG)
	-docker rmi dmoj/runtimes-tier1 dmoj/runtimes-tier1:$(TAG) ghcr.io/dmoj/runtimes-tier1:$(TAG)
	docker builder prune -a -f

test: test-tier1 test-tier2 test-tier3

test-tier1:
	docker run --rm -v "`pwd`/test":/code --cap-add=SYS_PTRACE dmoj/runtimes-tier1

test-tier2:
	docker run --rm -v "`pwd`/test":/code --cap-add=SYS_PTRACE dmoj/runtimes-tier2

test-tier3:
	docker run --rm -v "`pwd`/test-tier3":/code --cap-add=SYS_PTRACE dmoj/runtimes-tier3
