#!/bin/bash

mkdir -p /tmp/grav-admin
mkdir -p /app/grav-admin
touch /tmp/grav-admin/index.php

vendor/bin/heroku-php-apache2 /tmp/grav-admin
