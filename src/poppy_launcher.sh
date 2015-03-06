#! /bin/bash

if [ `whoami` != "root" ];
then
    echo "You must run the app as root:"
    echo "sudo bash $0"
    exit 0
fi

wget https://raw.githubusercontent.com/nicolas-rabault/poppy_install/master/src/poppy_logo
mv poppy_logo /home/poppy_logo
sed -i /poppy_logo/d /home/poppy/.bashrc
echo cat /home/poppy_logo >> /home/poppy/.bashrc
echo 'Starting the Poppy environement installation' >> /home/poppy/install_log
sed -i /install_log/d /home/poppy/.bashrc
echo tail -f /home/poppy/install_log >> /home/poppy/.bashrc

# allow poppy to use sudo without password
chmod +w /etc/sudoers
echo "poppy ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
chmod -w /etc/sudoers
usermod --pass='*' root # don't need root password any more
export HOME=/home/poppy

# Update needed apps.

#popy creatures installer
su - poppy -c "curl -L https://raw.githubusercontent.com/pierre-rouanet/build-raspbian-image/master/delivery/poppy-installer | bash -s poppy-humanoid"  >> /home/poppy/install_log

# Remove instalation at startup
sed -i /install_log/d /home/poppy/.bashrc
crontab -r

echo 'System install complete!' >> /home/poppy/install_log
echo "Please share your experiences with the community : https://forum.poppy-project.org/"  >> /home/poppy/install_log
