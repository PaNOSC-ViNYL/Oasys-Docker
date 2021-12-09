# Makefile for building && publishing
#REGISTRY=registry.elettra.eu:5000
HUBUSER=ceric
LOCALTAG=oasys:20
TAG=oasys.20
REPO=panosc-oasys-local
#IMAGE=`cat werf.yaml |grep image|awk '{print $NF}'`


build:
	docker build . -t $(LOCALTAG)

publish:
	docker tag $(LOCALTAG) $(HUBUSER)/$(REPO):$(TAG)
	docker push $(HUBUSER)/$(REPO):$(TAG)

#all: 
#	werf build-and-publish $(IMAGE) \
#		--stages-storage :local \
#	        --images-repo $(REGISTRY)/$(REPO) \
#		--tag-custom $(TAG)

#clean:
#	 werf stages purge --force -s :local

#publish:
#	werf publish $(IMAGE) \
#		--stages-storage :local \
#	        --images-repo $(REGISTRY)/$(REPO) \
#		--tag-custom $(TAG)
