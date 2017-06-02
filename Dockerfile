FROM ubuntu:16.04

RUN apt-get update -y; \
	apt-get install -y \
	apt-utils \
	apt-transport-https \
	lsb-release \
	curl;

## Install docker client
RUN curl -fsSLO https://get.docker.com/builds/Linux/x86_64/docker-17.04.0-ce.tgz \
  && tar xzvf docker-17.04.0-ce.tgz \
  && mv docker/docker /usr/local/bin \
  && rm -r docker docker-17.04.0-ce.tgz \
  && docker --version;

## Install Google Cloud SDK
RUN export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"; \
	echo "deb https://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list; \
	curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -; \
	apt-get update -y; \
	DEBIAN_FRONTEND=noninteractive apt-get install -y google-cloud-sdk; \
	gcloud --version;
