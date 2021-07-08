#!/bin/bash
echo "|-----------------------------------------|"
echo "|---Traefik reverse proxy autoinstaller---|"
echo "|-----------------------------------------|"
echo "|--------------version 0.0.2--------------|"
echo "|-----------------------------------------|"

sudo apt-get update -y && apt-get upgrade -y

# Checks if htpasswd is available or installs it otherwise
which htpasswd >/dev/null || (sudo apt-get install apache2-utils)
# Checks if git is installed
which git >/dev/null || (sudo apt-get install git)
# Checks if docker is installed (if not installs it alongside docker-compose)
which docker >/dev/null || (sudo apt-get install docker docker-compose)


# Starting configuration
echo "Starting configuration..."
mkdir traefik
cd traefik
git clone https://github.com/HugoDemaret/Traefik-docker.git
mv Traefik-docker/* .
rm -r Traefik-docker/.git*
rmdir Traefik-docker

# Taking the required information
read -p "Enter your email address:" emailaddress
read -p "Enter the url " url
echo "Your Traefik monitoring app will be deployed at:"
echo "traefik."$url
echo "|----------------------------|"
echo "|--Configuring your traefik--|"
echo "|----------------------------|"
# Replaces by the user information
sed -i -e"s/\/PATH\/TO/./g" docker-compose.yml
sed -i -e"s/\/PATH\/TO/./g" start.sh
sed -i -e"s/email@example.com/$emailaddress/g" traefik.toml
sed -i -e"s/your.url/$url/g" docker-compose.yml
echo "Done !"
echo "|----------------------------|"
echo "|--Creating authentication---|"
echo "|----------------------------|"

# Asks username and password
read -p "User: "  USER
read -p "Password: "  PW

# Generate strings
string=$(htpasswd -nbB $USER $PW)

# Escapes string for docker-compose
echo "debug 1"
credentials=$(echo "$string" | sed -e"s/\$/\$\$/g")
echo "debug 2"
sed -i -e"s/name_of_user\:hashed_password/$credentials/g" docker-compose.yml

# Modify the owner (so it is root)
path=$(pwd)
chown 0:0 $path
# Creates acme.json and sets its permissions
touch acme.json
chmod 600 acme.json

echo "|----------------------------|"
echo "|------------DONE------------|"
echo "|----------------------------|"

