apt-get update
apt-get install -y curl unzip tree vim nginx php5-fpm php5-curl php5-dev php5-cli php5-gd

curl -L https://github.com/howardroark/GravOps/archive/master.tar.gz -o /tmp/gravops.tar.gz
mkdir /project
tar -xvf /tmp/gravops.tar.gz --strip 1 -C /project

cd /project/ops/web

cp files/www.conf /etc/php5/fpm/pool.d/www.conf
cp files/nginx.conf /etc/nginx/nginx.conf
service php5-fpm restart
service nginx restart

if [ -d /grav-admin ] ; then
    echo "Grav is already installed"
else
    curl -L https://github.com/getgrav/grav/releases/download/1.0.10/grav-admin-v1.0.10.zip -o /tmp/grav-admin.zip > /dev/null
    if [ `md5sum /tmp/grav-admin.zip | awk '{ print $1 }'` != "6bb6250e7e3cce7c95a78df04478b767" ]
        then exit 1
    fi
    unzip /tmp/grav-admin.zip -d /
    chown -R gravops:gravops /grav-admin
    rm -rf /grav-admin/user
fi

chown -R gravops:gravops /project

ln -s /project /grav-admin/user

mkdir -p /home/gravops/.ssh
cp /root/.ssh/authorized_keys /home/gravops/.ssh/.
chmod -R gravops:gravops /home/gravops/.ssh
