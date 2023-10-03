FROM ghcr.io/runatlantis/atlantis:v0.25.0
USER root
ENV TOOLS_DIR=/home/atlantis/tools
ENV SRC_DIR=/home/atlantis/src
RUN mkdir -p /home/atlantis/src
RUN curl -LO https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/openshift-client-linux.tar.gz && \
    tar -xf openshift-client-linux.tar.gz && \
    mv oc /usr/local/bin && \
    rm openshift-client-linux.tar.gz

COPY install-tools.sh /usr/local/bin/install-tools.sh
RUN mkdir -p /home/atlantis/.ssh
#RUN ssh-keyscan github.ibm.com >> /home/atlantis/.ssh/known_hosts
WORKDIR /home/atlantis
USER atlantis
