apt-get update
apt-get install -y git curl unzip tree vim nginx php5-fpm php5-curl php5-dev php5-cli php5-gd

useradd -m grav-base

curl -L https://github.com/howardroark/grav-base/archive/master.tar.gz -o /tmp/grav-base.tar.gz
mkdir /project
tar -xvf /tmp/grav-base.tar.gz --strip 1 -C /project
chown -R grav-base:grav-base /project

cd /project/.ops/do

git init --shared --bare /project.git
cp files/post-receive /project.git/hooks/post-receive
chmod +x /project.git/hooks/post-receive
chown -R grav-base:grav-base /project.git

su - grav-base -c "git config --global user.email \"email@example.com\""
su - grav-base -c "git config --global user.name \"Grav Base\""
su - grav-base -c "cd /project && git init && git add . && git commit -m 'Initial commit' && git remote add origin /project.git && git push origin master"

su - grav-base -c "crontab /project/.ops/do/files/cronjobs.txt"

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
    chown -R grav-base:grav-base /grav-admin
    rm -rf /grav-admin/user
    ln -s /project/user /grav-admin/user
fi

mkdir -p /home/grav-base/.ssh
cp /root/.ssh/authorized_keys /home/grav-base/.ssh/.
chown -R grav-base:grav-base /home/grav-base/.ssh
