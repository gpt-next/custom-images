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
RUN wget https://github.com/transcend-io/terragrunt-atlantis-config/releases/download/v1.16.0/terragrunt-atlantis-config_1.16.0_linux_amd64.tar.gz && \
    tar xf terragrunt-atlantis-config_1.16.0_linux_amd64.tar.gz && \
    mv terragrunt-atlantis-config_1.16.0_linux_amd64/terragrunt-atlantis-config_1.16.0_linux_amd64 terragrunt-atlantis-config && \
    install terragrunt-atlantis-config /usr/local/bin
#RUN ssh-keyscan github.ibm.com >> /home/atlantis/.ssh/known_hosts
COPY .tool-versions /home/atlantis/.tool-versions
RUN rm -rf ${TOOLS_DIR} && install-tools.sh
WORKDIR /home/atlantis
USER atlantis
