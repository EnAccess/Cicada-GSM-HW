# Define variables for KiBot
IMAGE_NAME := ghcr.io/inti-cmnb/kicad7_auto_full:latest
# specify platform to be sure we can run on Apple Silicons
DOCKER_RUN := docker run --rm --platform linux/amd64
DOCKER_VOLUME := -v "$(shell pwd)/design/source/kicad":/mnt
DOCKER_WORKDIR_CICADA_2G := -w /mnt/cicada-2g
DOCKER_WORKDIR_CICADA_4G := -w /mnt/cicada-4g

# Define targets
.PHONY: kibot-2g-all kibot-2g-development kibot-2g-production kibot-4g-all kibot-4g-development kibot-4g-production

kibot-2g-all:
	$(DOCKER_RUN) $(DOCKER_VOLUME) $(DOCKER_WORKDIR_CICADA_2G) $(IMAGE_NAME) kibot all

kibot-2g-development:
	$(DOCKER_RUN) $(DOCKER_VOLUME) $(DOCKER_WORKDIR_CICADA_2G) $(IMAGE_NAME) kibot development

kibot-2g-production:
	$(DOCKER_RUN) $(DOCKER_VOLUME) $(DOCKER_WORKDIR_CICADA_2G) $(IMAGE_NAME) kibot production

kibot-4g-all:
	$(DOCKER_RUN) $(DOCKER_VOLUME) $(DOCKER_WORKDIR_CICADA_4G) $(IMAGE_NAME) kibot all

kibot-4g-development:
	$(DOCKER_RUN) $(DOCKER_VOLUME) $(DOCKER_WORKDIR_CICADA_4G) $(IMAGE_NAME) kibot development

kibot-4g-production:
	$(DOCKER_RUN) $(DOCKER_VOLUME) $(DOCKER_WORKDIR_CICADA_4G) $(IMAGE_NAME) kibot production
