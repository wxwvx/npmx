GITHUB_USER ?= wxwvx

# make check-sum-v0.1.0
check-sum-%:
	curl -L "https://github.com/$(GITHUB_USER)/npmx/archive/refs/tags/$*.tar.gz" | shasum -a 256
