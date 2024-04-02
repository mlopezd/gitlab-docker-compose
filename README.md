# Gitlab Docker Compose
 
This repository contains a docker compose file and other scripts that allows to deploy a fully working Gitlab instance, including a Container Registry and a Gitlab-Runner to be used in CI pipelines. It also supports LDAP auth configuration.

## How to use

### Setting required environment variables:

Set the following variables before running docker compose (you can do this in the .env file):

    INITIAL_ROOT_PASSWORD=pleasechangeme
    TIMEZONE=Australia/Sydney

Set the LDAP settings as environment variables:

    LDAP_SERVER_HOSTNAME=company.local
    LDAP_SERVER_IP=192.168.0.20
    LDAP_BIND_DN='cn=ldap bind,ou=administrators,ou=users,dc=company,dc=local'
    LDAP_BIND_PASS=supersecretpassword
    LDAP_BASE='ou=users,dc=company,dc=local'

If you are using a self-signed or privately signed certificate for LDAP, copy it in the trusted-certs folder.

### Starting the docker compose containers

Start a both **gitlab-ce** AND **gitlab-runner** containers:

    docker compose up

Start only the **gitlab-ce** container:

    docker compose up gitlab-ce

### Registering the gitlab-runner

Ensure Gitlab is up and running at https://gitlab.local:8443, generate a private token and then run:

    register-runner.sh PRIVATE_TOKEN
