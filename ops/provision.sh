#!/bin/bash

cd /project

apt-get update
apt-get install -y git unzip tree vim nginx php5-fpm php5-curl php5-dev php5-cli php5-gd

cp ops/bash_profile /home/vagrant/.bash_profile
chown vagrant:vagrant /home/vagrant/.bash_profile

cp ops/gitconfig /home/vagrant/.gitconfig
chown vagrant:vagrant /home/vagrant/.gitconfig

cp ops/vimrc /home/vagrant/.vimrc
chown vagrant:vagrant /home/vagrant/.vimrc

if [ ! -f /usr/local/bin/composer ] ; then
    curl -L https://getcomposer.org/download/1.0.0/composer.phar -o /tmp/composer.phar > /dev/null
    if [ `md5sum /tmp/composer.phar | awk '{ print $1 }'` != "0f2075852d10873da3c79ad9df774b26" ]
        then exit 1
    fi
    mv /tmp/composer.phar /usr/local/bin/composer
    chmod +x /usr/local/bin/composer
fi

cp ops/php.ini /etc/php5/fpm/php.ini
cp ops/fpm-pool-www.conf /etc/php5/fpm/pool.d/www.conf
service php5-fpm restart

cp ops/nginx.conf /etc/nginx/nginx.conf
service nginx restart

if [ ! -d /home/vagrant/grav-admin ] ; then
    curl -L https://github.com/getgrav/grav/releases/download/1.0.10/grav-admin-v1.0.10.zip -o /tmp/grav-admin.zip > /dev/null
    if [ `md5sum /tmp/grav-admin.zip | awk '{ print $1 }'` != "4b0605c9b88e7119a0fc66296af364af" ]
        then exit 1
    fi
    unzip /tmp/grav-admin.zip -d /home/vagrant
    chown -R vagrant:vagrant /home/vagrant/grav-admin
    rm -rf /home/vagrant/grav-admin/user
    ln -s /project /home/vagrant/grav-admin/user
fi
