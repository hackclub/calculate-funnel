C=docker
IMG=hackclub/calculate-funnel
SHELL=/bin/bash

build:
	$(C) build -t $(IMG) .

shell:
	$(C) run --rm -it -v $(shell pwd):/usr/src/app $(IMG) $(SHELL)
