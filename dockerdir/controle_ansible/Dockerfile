# Amazon EC2
FROM amazonlinux:latest

# Update yum
RUN yum update -y
RUN yum upgrade -y

# Install Components by yum
RUN yum install -y sudo
RUN yum install -y shadow-utils
RUN yum install -y procps
RUN yum install -y which
RUN yum install -y iproute
RUN yum install -y e2fsprogs
RUN yum install -y openssh-server
RUN yum install -y openssh-clients
# Clear Cache
RUN yum clean all
# Install Ansible By yum
RUN sudo amazon-linux-extras enable ansible2
RUN sudo yum install -y ansible

# Setup Ansible
RUN mkdir -p /etc/ansible
COPY ./ansible_component/hosts /etc/ansible
COPY ./ansible_component/playbook.yml /etc/ansible
COPY ./ansible_component/ansible.cfg /etc/ansible

# Creating a public key for working ssh login
RUN ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa
RUN ssh-keygen -f /etc/ssh/ssh_host_ecdsa_key -N '' -t ecdsa

# Enable PasswordLogin
RUN sed -ri 's/^#PermitEmptyPasswords no/PermitEmptyPasswords yes/' /etc/ssh/sshd_config

# Add User ec2-user
RUN useradd ec2-user
# Add sudoers to ec2-user
RUN echo "ec2-user ALL=NOPASSWD: ALL" >> /etc/sudoers
# Specify the password for ec2-user
RUN echo "ec2-user:passwd" | chpasswd

# Move Local private key & ssh config to Ansible Server
COPY ./privatekey/id_rsa /home/ec2-user/.ssh/
COPY ./ansible_component/config /home/ec2-user/.ssh/

# Update Permission private key
RUN sudo chmod 600 /home/ec2-user/.ssh/id_rsa
RUN sudo chown ec2-user:ec2-user /home/ec2-user/.ssh/id_rsa

# Update Permission ssh config
RUN sudo chmod 600 /home/ec2-user/.ssh/config
RUN sudo chown ec2-user:ec2-user /home/ec2-user/.ssh/config

# OpenPort [22]
EXPOSE 22

# Start sshd
CMD ["/usr/sbin/sshd", "-D"]