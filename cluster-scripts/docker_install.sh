echo -e "---------------------------------------------------------------------------------"
echo "Step 1 - Installing Docker"
echo -e "---------------------------------------------------------------------------------"

echo "update your existing list of packages"
sudo apt-get update -y

echo "install a few prerequisite packages which let apt use packages over HTTPS"
sudo apt install apt-transport-https ca-certificates curl software-properties-common

echo "add the GPG key for the official Docker repository to your system"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

echo "add the Docker repository to APT sources"
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"

echo "this has updated our package database with the Docker packages from the newly added repo"
echo "make sure you are about to install from the Docker repo instead of the default Ubuntu repo"
apt-cache policy docker-ce

echo "install Docker"
sudo apt install docker-ce -y

echo "Docker should now be installed, the daemon started, and the process enabled to start on boot"
echo "check that Docker is running"
sudo systemctl status docker

echo -e "---------------------------------------------------------------------------------"
echo "Step 2 - Executing the Docker Command Without Sudo"
echo -e "---------------------------------------------------------------------------------"

echo"avoid typing sudo whenever you run the docker command, add your username to the docker group"
sudo usermod -aG docker ${USER}

echo "apply the new group membership, log out of the server and back in, or type the following"
echo "you will be prompted to enter your password to continue"
su - ${USER}

echo "confirm that your user is now added to the docker group by typing"
groups

echo "if you need to add another user to the docker group, declare that username explicitly using"
sudo usermod -aG docker username

echo -e "---------------------------------------------------------------------------------"

echo -e "---------------------------------------------------------------------------------"
echo "Step 3 — Using the Docker Command"
echo -e "---------------------------------------------------------------------------------"
echo "from this point on run the docker command as a user in the docker group"
echo 

docker --version
docker
