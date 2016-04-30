cd /project/ops/dev

apt-get update
apt-get install -y git unzip tree vim nginx php5-fpm php5-curl php5-dev php5-cli php5-gd

cp files/bash_profile /home/vagrant/.bash_profile
chown vagrant:vagrant /home/vagrant/.bash_profile

cp files/gitconfig /home/vagrant/.gitconfig
chown vagrant:vagrant /home/vagrant/.gitconfig

cp files/vimrc /home/vagrant/.vimrc
chown vagrant:vagrant /home/vagrant/.vimrc

cp files/nginx.conf /etc/nginx/nginx.conf
service nginx restart

cp files/www.conf /etc/php5/fpm/pool.d/www.conf
service php5-fpm restart

if which composer; then
    echo "Composer is already installed."
else
    curl -L https://getcomposer.org/download/1.0.0/composer.phar -o /tmp/composer.phar > /dev/null
    if [ `md5sum /tmp/composer.phar | awk '{ print $1 }'` != "0f2075852d10873da3c79ad9df774b26" ]
        then exit 1
    fi
    mv /tmp/composer.phar /usr/local/bin/composer
    chmod +x /usr/local/bin/composer
fi

if [ -d /grav-admin ] ; then
    echo "Grav is already installed"
else
    curl -L https://github.com/getgrav/grav/releases/download/1.0.10/grav-admin-v1.0.10.zip -o /tmp/grav-admin.zip > /dev/null
    if [ `md5sum /tmp/grav-admin.zip | awk '{ print $1 }'` != "6bb6250e7e3cce7c95a78df04478b767" ]
        then exit 1
    fi
    unzip /tmp/grav-admin.zip -d /
    chown -R vagrant:vagrant /grav-admin
    rm -rf /grav-admin/user
    ln -s /project /grav-admin/user
fi
