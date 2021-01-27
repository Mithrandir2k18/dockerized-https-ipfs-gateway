#!/bin/bash

# These values are required for your SSL cert to work. Please add them!
domain=mydomain.com
email=ssl@mydomain.com


echo "Creating folders for docker volumes!"
mkdir -p data/nginx
mkdir -p data/certbot/conf
mkdir -p data/certbot/www
mkdir -p data/ipfs

path=/etc/letsencrypt/live/$domain
mkdir -p ./data/certbot/conf/live/$domain
data_path=./data/certbot
mkdir -p "$data_path/conf"


docker-compose up -d ipfs_host
echo "Sleeping for 5 seconds, then trying to print connected peers. If you don't see any, something might be wrong!"
sleep 5
echo $(docker-compose exec ipfs_host ipfs swarm peers)
echo "Now let's also test if we can grab some data. You should see a greeting printed to the screen next!"
echo $(curl http://127.0.0.1:8080/ipfs/QmPChd2hVbrJ6bfo3WBcTW4iZnpHm8TEzWkLHmLpXhF68A)

echo "Now setting up ipfs-configs!"
docker-compose exec ipfs_host ipfs config Addresses.Swarm '["/ip4/0.0.0.0/tcp/4001", "/ip4/0.0.0.0/tcp/8081/ws", "/ip6/::/tcp/4001"]' --json
docker-compose exec ipfs_host ipfs config --bool Swarm.EnableRelayHop true 
docker-compose exec ipfs_host ipfs config --bool Swarm.EnableAutoRelay true
docker-compose exec ipfs_host ipfs config AutoNAT.ServiceMode '"enabled"' --json


echo "Adding config files to the volumes!"
cp nginx.conf ./data/nginx/app.conf
curl -s https://raw.githubusercontent.com/certbot/certbot/master/certbot-nginx/certbot_nginx/_internal/tls_configs/options-ssl-nginx.conf > "$data_path/conf/options-ssl-nginx.conf"
curl -s https://raw.githubusercontent.com/certbot/certbot/master/certbot/certbot/ssl-dhparams.pem > "$data_path/conf/ssl-dhparams.pem"

echo "Now creating a temporary certificate so nginx can start. Make sure you set your domain in the bash file as well!"
sleep 5

docker-compose run --rm --entrypoint "\
          openssl req -x509 -nodes -newkey rsa:1024 -days 1\
          -keyout '$path/privkey.pem' \
          -out '$path/fullchain.pem' \
          -subj '/CN=localhost'" certbot

echo "Now starting up ipfs and nginx. Printing logs of nginx, if there's any errors stop this script and debug!"
docker-compose up -d ipfs_host
docker-compose up -d nginx

echo $(docker-compose logs nginx)
sleep 5

echo "Deleting temporary cert and starting grabbing the actual one!"
echo "For the final cert you'll need to answer some questions. Please do so!"
docker-compose run --rm --entrypoint "\
          certbot certonly --webroot -w /var/www/certbot \
          --email $email \
          -d $domain
          --rsa-key-size 4096 \
          --agree-tos \
          --force-renewal" certbot

docker-compose down
echo "Everything should be ready now! Starting..."
docker-compose up -d

