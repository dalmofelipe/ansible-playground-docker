FROM centos:latest
LABEL maintainer="dalmofelipe.dev@gmail.com"
RUN cd /etc/yum.repos.d/ && \
  sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-* && \
  sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-* && \
  dnf update -y && \
  dnf upgrade -y && \
  dnf install epel-release -y && \
  dnf install python3 openssh-server openssh-clients -y && \
  ssh-keygen -A && \
  mkdir -p /run/sshd
CMD [ "/usr/sbin/sshd", "-D" ]