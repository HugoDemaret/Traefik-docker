# Traefik docker configuration
## With Let's Encrypt certificate !


# Automatic installation :

Run the following and follow the instructions :
> wget https://github.com/HugoDemaret/traefik_installer/blob/0a1ef6f0be7e558eec1a140b490a9e234efac970/traefik_installer.sh
<br>sudo bash traefik_installer.sh

# Manual installation :

- Install docker and docker compose
> apt-get install docker docker-compose
- Copy this repository
> git clone https://github.com/HugoDemaret/Traefik-docker.git
- Replace your.url in docker-compose.yml by your URL
- Set the path to your installation in docker-compose.yml
- Set your email address in traefik.toml

- Run the authcreate.sh script and follow the instructions
> wget https://github.com/HugoDemaret/authcreate/blob/36f42da04972cc73b958405a95bd0679475364fc/authcreate.sh
> sudo bash authcreate.sh
- Replace name_of_user:hashed_password by the user name and the hash generated previously

- Create a file named acme.json and set its permissions to 600
> touch acme.json
<br>chmod 600 acme.json

- Run start.sh
> sudo bash start.sh


## To do list:
1. Make an automation bash script
2. Improve the current README.md file by making it more readable and user-friendly
3. Make a windows version
