# Traefik docker configuration
## With Let's Encrypt certificate !


# Automatic installation :

- Run the following and follow the instructions :

```sudo bash auto_installer.sh```

# Manual installation :

- Install docker and docker compose

```apt-get install docker docker-compose```

- Copy this repository

```git clone https://github.com/HugoDemaret/Traefik-docker.git```

- Replace your.url in docker-compose.yml by your URL
- Set the path to your installation in docker-compose.yml
- Set your email address in traefik.toml

- Run the authcreate.sh script and follow the instructions

```sudo bash auth_create.sh```

- Replace name_of_user:hashed_password by the user name and the hash generated previously

- Create a file named acme.json and set its permissions to 600

```touch acme.json```
```chmod 600 acme.json```

- Run start.sh

```sudo bash start.sh```


## To do list:
1. Improve the current README.md file by making it more readable and user-friendly :
2. Make a windows version
