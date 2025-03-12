
# base image
FROM ubuntu:24.04

#input GitHub runner version argument
ARG RUNNER_VERSION
ENV DEBIAN_FRONTEND=noninteractive

LABEL RunnerVersion=${RUNNER_VERSION}

# update the base packages + add a non-sudo user
RUN apt-get update -y && apt-get upgrade -y && useradd -m docker

# install the packages and dependencies along with jq so we can parse JSON (add additional packages as necessary)
RUN apt-get update && apt-get install -y --no-install-recommends curl nodejs wget unzip vim git 

RUN apt-get update && apt-get install -y --no-install-recommends jq build-essential

RUN apt-get update && apt-get install -y --no-install-recommends libssl-dev libffi-dev python3 

RUN apt-get update && apt-get install -y --no-install-recommends python3-venv python3-dev python3-pip

# cd into the user directory, download and unzip the github actions runner
WORKDIR /home/docker/actions-runner
RUN curl -o actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz -L https://github.com/actions/runner/releases/download/v2.322.0/actions-runner-linux-x64-2.322.0.tar.gz
RUN tar xzf ./actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz
# install some additional dependencies
# RUN chown -R docker ~docker && /home/docker/actions-runner/bin/installdependencies.sh

# add over the start.sh script
ADD scripts/start.sh start.sh

# make the script executable
RUN chmod +x start.sh

# set the user to "docker" so all subsequent commands are run as the docker user
USER docker

# set the entrypoint to the start.sh script
ENTRYPOINT ["./start.sh"]