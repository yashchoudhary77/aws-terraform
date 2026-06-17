#!/bin/bash

sudo apt-grt update
sudo apt-get install nginx -y
sudo systemctl start nignx
sudo systemctl enable nginx

echo "<h1>DevOps Engineer </h1>" | sudo tee /var/www/html/index.html