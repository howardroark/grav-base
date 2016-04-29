#!/bin/bash

mkdir -p /app/grav-admin
touch /app/grav-admin/index.php

vendor/bin/heroku-php-apache2 /app/grav-admin
