#!/bin/bash
echo "|-----------------------------------------|\n"
echo "|---Traefik reverse proxy autoinstaller---|\n"
echo "|-----------------------------------------|\n"
echo "|--------------version 0.0.2--------------|\n"
echo "|-----------------------------------------|\n"

sudo apt-get update -y && apt-get upgrade -y

# Checks if htpasswd is available or installs it otherwise
which htpasswd >/dev/null || (sudo apt-get install apache2-utils)
# Checks if git is installed
which git >/dev/null || (sudo apt-get install git)
# Checks if docker is installed (if not installs it alongside docker-compose)
which docker >/dev/null || (sudo apt-get install docker docker-compose)


# Starting configuration
echo "Starting configuration...\n"
mkdir traefik
cd traefik
git clone https://github.com/HugoDemaret/Traefik-docker.git

# Taking the required information
read -p "Enter your email address:\n" emailaddress
read -p "Enter the url \n" url
echo "Your Traefik monitoring app will be deployed at:\n"
echo $url
echo "|----------------------------|\n"
echo "|--Configuring your traefik--|\n"
echo "|----------------------------|\n"
# Replaces by the user information
sed -i -e"s/\/PATH\/TO/./g" docker-compose.yml
sed -i -e"s/\/PATH\/TO/./g" start.sh
sed -i -e"s/email@example.com/$emailaddress/g" traefik.toml
sed -i -e"s/your.url/$url/g" docker-compose.yml
echo "|----------------------------|\n"
echo "|--Creating authentication---|\n"
echo "|----------------------------|\n"

# Asks username and password
read -p "User: "  USER
read -p "Password: "  PW

# Generate strings
string=$(htpasswd -nbB $USER $PW)

# Escapes string for docker-compose
credentials=$(echo "$string" | sed -e 's/\$/\$\$/g')
sed -i -e"s/name_of_user:hashed_password/$credentials/" docker-compose.yml

# Modify the owner (so it is root)
path=$(pwd)
chown 0:0 $path
# Creates acme.json and sets its permissions
touch acme.json
chmod 600 acme.json

echo "|----------------------------|\n"
echo "|------------DONE------------|\n"
echo "|----------------------------|\n"

