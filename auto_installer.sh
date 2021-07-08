#!/bin/bash
cat << 'EOF'
 _____               __ _ _     ___        _       _____          _        _ _           
|_   _|             / _(_) |   / _ \      | |     |_   _|        | |      | | |          
  | |_ __ __ _  ___| |_ _| | _/ /_\ \_   _| |_ ___  | | _ __  ___| |_ __ _| | | ___ _ __ 
  | | '__/ _` |/ _ \  _| | |/ /  _  | | | | __/ _ \ | || '_ \/ __| __/ _` | | |/ _ \ '__|
  | | | | (_| |  __/ | | |   <| | | | |_| | || (_) || || | | \__ \ || (_| | | |  __/ |   
  \_/_|  \__,_|\___|_| |_|_|\_\_| |_/\__,_|\__\___/\___/_| |_|___/\__\__,_|_|_|\___|_|   
EOF
VERSION='0.0.2'
echo "Version : $VERSION"

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
credentials=$(echo "$string" | sed -e"s/\$/\$\$/g")
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

