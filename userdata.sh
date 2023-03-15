#!/bin/bash
#  basic userdata for an ec2 with docker engine

echo "Info: Executing userdata.sh script."

/usr/bin/timedatectl set-timezone America/Los_Angeles

INSTID=`curl http://169.254.169.254/latest/meta-data/instance-id`
REGION=`curl -s http://169.254.169.254/latest/meta-data/public-hostname | awk -F. '{print $2}'`
HN=`aws ec2 describe-instances --instance-id $INSTID --region $REGION --query 'Reservations[*].Instances[*].[PublicIpAddress,Tags[?Key==\`Name\`]]' --output text | grep Name | awk '{print $2}' `

/bin/hostname $HN
echo PS1=\"[\\u@$HN]\" >> /etc/bashrc 
cat /etc/hosts | sed "s/localhost/localhost $HN/" > /tmp/hosts
cp -p /tmp/hosts /etc/hosts

systemctl restart sshd.service

#  add docker repository (optional)
apt-get update
apt-get install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common git
curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian bullseye stable"


#  install docker and docker-composer (optional)
apt-get update
apt-get install -y docker-ce docker-compose
service docker restart 

#  create application acount and grant appadmin access to docker (optional)
useradd -s /bin/bash -m -d /home/appadmin -c "Application Admin" appadmin
usermod -a -G docker appadmin
usermod -a -G sudo appadmin

#  The runcmd-v2 will figure out if there is any additional filesystem to attach and mount.
#  It also check to see if a reserved fixed IP also need to be set for this server.

cd /tmp
git clone https://github.com/toaigit/post-scripts.git
cd post-scripts
./runcmd-v2

echo "Info: Completed the userdata.sh script"
#  end of userdata script
