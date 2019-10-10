all: image-tier1

image-tier1:
	cd tier1 && docker build -t dmoj/runtimes-tier1:latest .
