#!/bin/bash

openssl req \
	-new \
	-newkey rsa:4096 \
	-sha256 \
	-days 3650 \
	-nodes \
	-x509 \
	-subj "/C=AU/ST=NSW/L=Sydney/O=Company/CN=gitlab.local"  \
	-addext "subjectAltName=DNS:gitlab.local,DNS:*.gitlab.local" \
	-keyout gitlab.local.key \
	-out gitlab.local.crt