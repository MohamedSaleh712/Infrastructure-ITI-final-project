FROM jenkins/jenkins:lts-jdk11
LABEL description="build jenkins image with docker and kubectl"

USER root
#install Dcoker inside jenkins container
RUN apt-get update \
  && apt-get -y install apt-transport-https ca-certificates curl gnupg lsb-release \
  && curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg \
  && echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
     $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null \
  && apt-get update \
  && apt-get -y install docker-ce docker-ce-cli containerd.io
  
# Add jenkins user to docker group
RUN usermod -aG docker jenkins

RUN apt-get install -y gettext

#install kubectl inside jenkins container
RUN curl -LO "https://dl.k8s.io/release/$(curl -Ls https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
    chmod +x kubectl && \
    mv kubectl /usr/local/bin/kubectl

USER jenkins