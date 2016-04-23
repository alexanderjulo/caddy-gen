# caddy-gen

Automatically generate a central Caddyfile for many containers.

First off, start the generator container:

    docker run -e LETSENCRYPT_EMAIL=<your email> -v <somepath>:/etc/caddy -v /var/run/docker.sock:/var/run/docker.sock alexanderjulo/caddy-gen

Then start whatever service you want to be proxied (which has to either expose or publish the port you want to be exposed to the open):

    docker run -e VIRTUAL_HOST=<domain> -p <yourport> dockercloud/hello-world

Then start a caddy container that will handle all your outbound traffic:

    docker run -l autocaddy=1 -v <somepath>:/var/www/html/Caddyfile:ro -v sslcerts:/etc/ssl/certs -p 80:80 -p 443:443 joshix/caddy
