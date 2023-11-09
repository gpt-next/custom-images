FROM --platform=linux/amd64 quay.io/buildah/stable:latest
USER root
ARG RUNNER_VERSION="2.294.0"

# Prevents installdependencies.sh from prompting the user and blocking the image creation
ARG DEBIAN_FRONTEND=noninteractive
ENV RUNNER_ALLOW_RUNASROOT=1


#RUN yum update -y && yum upgrade -y
RUN yum install -y curl jq python3 python3-pip
RUN cd / && mkdir actions-runner && cd actions-runner \
    && curl -O -L https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz \
    && tar xzf ./actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz

# Use chroot since the default runc does not work when running rootless
#RUN echo "export BUILDAH_ISOLATION=chroot" >> /home/build/.bashrc
ENV DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1
# Use VFS since fuse does not work
#RUN mkdir -p /home/build/.config/containers \
#&& (echo '[storage]';echo 'driver = "vfs"') > /home/build/.config/containers/storage.conf

RUN /actions-runner/bin/installdependencies.sh

COPY start.sh start.sh

# make the script executable
RUN chmod +x start.sh


# since the config and run script for actions are not allowed to be run by root,
# set the user to "build" so all subsequent commands are run as the build user
#USER build

ENTRYPOINT ["./start.sh"]