# Amazon EC2
FROM amazonlinux:latest

# Supervisor の設定を Docker イメージ内に転送する
ADD ./supervisord/supervisord.conf /etc/supervisord.conf

# Install EPEL by amazon-linux-extras
RUN yum install -y sudo
RUN sudo amazon-linux-extras install -y epel
# Install Components by yum
RUN yum install -y python-pip
RUN yum install -y httpd
RUN yum install -y shadow-utils
RUN yum install -y procps
RUN yum install -y which
RUN yum install -y iproute
RUN yum install -y e2fsprogs
RUN yum install -y openssh-server
RUN yum install -y openssh-clients

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

# Creating a public key for Ansible ssh connection
COPY ./publickey/id_rsa.pub /tmp/
RUN sudo -u ec2-user mkdir -p /home/ec2-user/.ssh
RUN mv /tmp/id_rsa.pub /home/ec2-user/.ssh/
RUN chmod -R go-rwx /home/ec2-user/.ssh
RUN cat /home/ec2-user/.ssh/id_rsa.pub >> /home/ec2-user/.ssh/authorized_keys

# Install Supervisor by pip
RUN pip install supervisor

# Create Test Page to httpd
RUN echo "<html>" >> /var/www/html/index.html
RUN echo "<head><title>Success Page</title></head>" >> /var/www/html/index.html
RUN echo "<h2>Success Page - Project Create Ansible On ECS(EC2)</h2>" >> /var/www/html/index.html
RUN echo "<p>This is Ansible Target Container</p>" >> /var/www/html/index.html
RUN echo "</html>" >> /var/www/html/index.html

# OpenPort [22,80]
EXPOSE 22 80

# Start Supervisor
CMD ["/usr/bin/supervisord"]