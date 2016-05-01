apt-get update
apt-get install -y git unzip tree vim nginx php5-fpm php5-curl php5-dev php5-cli php5-gd

useradd -m gravops

git clone https://github.com/howardroark/gravops.git /tmp/gravops
cd /tmp/gravops/ops/web

cp files/nginx.conf /etc/nginx/nginx.conf
service nginx restart

cp files/www.conf /etc/php5/fpm/pool.d/www.conf
service php5-fpm restart

mkdir -p /home/gravops/.ssh
cp /root/.ssh/authorized_keys /home/gravops/.ssh/.
chmod -R gravops:gravops /home/gravops/.ssh

if [ -d /grav-admin ] ; then
    echo "Grav is already installed"
else
    curl -L https://github.com/getgrav/grav/releases/download/1.0.10/grav-admin-v1.0.10.zip -o /tmp/grav-admin.zip > /dev/null
    if [ `md5sum /tmp/grav-admin.zip | awk '{ print $1 }'` != "6bb6250e7e3cce7c95a78df04478b767" ]
        then exit 1
    fi
    unzip /tmp/grav-admin.zip -d /
    chown -R gravops:gravops /grav-admin
fi

rm -rf /tmp/gravops
