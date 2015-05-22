# sfu-nginx-php

Docker image that creates an Nginx/PHP stack.

Created for use with [munkireport-php](https://github.com/munkireport/munkireport-php).

Much thanks and code lifted from [Pepjin](https://github.com/macadmins/munkireport-php) and others.

# Example

`docker build -t nginx-php .`

`docker run --rm -ti --name php -p 80:80 -v ${PWD}/munkireport-php:/app -v ${PWD}/data:/appdata`

