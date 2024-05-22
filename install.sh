#! /bin/bash

# You need to be root
USER=`whoami`
[ "$USER" != "root" ] && echo 'You need to be root'
[ "$USER" != "root" ] && exit

echo '###################################'
echo '### Database Variables'
echo '####################################'
echo ''

PHP_VERSION='7.4'
echo "PHP Version - Default: $PHP_VERSION"
read PROMPT
[  -z "$PROMPT" ] && echo 'Keep Default' || PHP_VERSION=$PROMPT
echo "PHP Versiion: $PHP_VERSION"
echo ""

DB_DRIVER='pgsql'
echo "Database Driver - Default: $DB_DRIVER"
read PROMPT
[  -z "$PROMPT" ] && echo 'Keep Default' || DB_DRIVER=$PROMPT
echo "Database Driver: $DB_DRIVER"
echo ""

DB_HOST='localhost'
echo "Database Host - Default: $DB_HOST"
read PROMPT
[  -z "$PROMPT" ] && echo 'Keep Default' || DB_HOST=$PROMPT
echo "Database Host: $DB_HOST"
echo ""

DB_NAME='moodle'
echo "Database Name - Default: $DB_NAME"
read PROMPT
[  -z "$PROMPT" ] && echo 'Keep Default' || DB_NAME=$PROMPT
echo "Database Name: $DB_NAME"
echo ""

DB_USER='moodle'
echo "Database User - Default: $DB_USER"
read PROMPT
[  -z "$PROMPT" ] && echo 'Keep Default' || DB_USER=$PROMPT
echo "Database User: $DB_USER"
echo ""

DB_PASS=`openssl rand -base64 16`
echo "Database Pass - Default: $DB_PASS"
read PROMPT
[  -z "$PROMPT" ] && echo 'Keep Default' || DB_PASS=$PROMPT
echo "Database Pass: $DB_PASS"
echo ""

DB_PREFIX='mdl_'
echo "Database Prefix - Default: $DB_PREFIX"
read PROMPT
[  -z "$PROMPT" ] && echo 'Keep Default' || DB_PREFIX=$PROMPT
echo "Database Prefix: $DB_PREFIX"
echo ""

DB_PORT='5432'
echo "Database Port - Default: $DB_PORT"
read PROMPT
[  -z "$PROMPT" ] && echo 'Keep Default' || DB_PORT=$PROMPT
echo "Database Port: $DB_PORT"
echo ""

echo '###################################'
echo '## Path Variables'
echo '###################################'
echo ''

MOODLE_VERSION='v3.9.11'
echo "MOODLE VERSION - Default: $MOODLE_VERSION"
read PROMPT
[  -z "$PROMPT" ] && echo 'Keep Default' || MOODLE_VERSION=$PROMPT
echo "MOODLE VERSION: $MOODLE_VERSION"
echo ""

MOODLE_PATH='/var/www/html/moodle'
echo "MOODLE PATH - Default: $MOODLE_PATH"
read PROMPT
[  -z "$PROMPT" ] && echo 'Keep Default' || MOODLE_PATH=$PROMPT
echo "MOODLE_PATH: $MOODLE_PATH"
echo ""

WWW_ROOT="http://`hostname -I`"
echo "WWW_ROOT - Default: $WWW_ROOT"
read PROMPT
[  -z "$PROMPT" ] && echo 'Keep Default' || WWW_ROOT=$PROMPT
echo "WWW_ROOT: $WWW_ROOT \n"
echo ""

MOODLE_DATA="/var/moodledata"
echo "Moodledata - Default: $MOODLE_DATA"
read PROMPT
[  -z "$PROMPT" ] && echo 'Keep Default' || MOODLE_DATA=$PROMPT
echo "Moodledata: $MOODLE_DATA \n"
echo ""

echo '###################################'
echo '## Moodle Install Variables'
echo '###################################'
echo ''

MOODLE_LANG='en'
echo "Moodle default language - Default: $MOODLE_LANG"
read PROMPT
[  -z "$PROMPT" ] && echo 'Keep Default' || MOODLE_LANG=$MOODLE_LANG
echo "Moodle default language: $MOODLE_LANG"
echo ""

MOODLE_NAME='New Moodle instance'
echo "Site Fullname  - Default: $MOODLE_NAME"
read PROMPT
[  -z "$PROMPT" ] && echo 'Keep Default' || MOODLE_NAME=$MOODLE_NAME
echo "Site Fullname  - Default: $MOODLE_NAME"
echo ""

MOODLE_SHORT='Moodle'
echo "Site Short name  - Default: $MOODLE_SHORT"
read PROMPT
[  -z "$PROMPT" ] && echo 'Keep Default' || MOODLE_SHORT=$MOODLE_SHORT
echo "Site Fullname  - Default: $MOODLE_SHORT"
echo ""

MOODLE_ADMIN='admin'
echo "Moodle admin USER - Default: $MOODLE_ADMIN"
read PROMPT
[  -z "$PROMPT" ] && echo 'Keep Default' || MOODLE_ADMIN=$MOODLE_ADMIN
echo "Moodle admin name: $MOODLE_ADMIN"
echo ""

MOODLE_EMAIL="admin@`hostname -I`.com"
echo "Moodle admin USER - Default: $MOODLE_EMAIL"
read PROMPT
[  -z "$PROMPT" ] && echo 'Keep Default' || MOODLE_EMAIL=$MOODLE_EMAIL
echo "Moodle admin name: $MOODLE_EMAIL"
echo ""

MOODLE_PASS=`openssl rand -base64 16`
echo "Moodle admin Pass - Default: $MOODLE_PASS"
read PROMPT
[  -z "$PROMPT" ] && echo 'Keep Default' || MOODLE_PASS=$MOODLE_PASS
echo "Moodle admin Pass: $MOODLE_PASS"
echo ""

echo "Do you agree with Moodle License? https://docs.moodle.org/dev/License"
echo "Type YES "
read PROMPT

[ $PROMPT != "YES" ] && echo "You need to agree to the license. Quiting"
[ $PROMPT != "YES" ] && exit

# Download and configure database
apt-get install postgresql
sudo -u postgres psql -c "CREATE USER $DB_USER WITH password '$DB_PASS';"
sudo -u postgres psql -c "CREATE DATABASE $DB_NAME;"
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE $DB_NAME TO $DB_USER;"

# Download and configure webservice
apt-get install apache2 php7.4 php7.4-pgsql php7.4-xml php7.4-mbstring php7.4-curl php7.4-zip php7.4-gd php7.4-gd php7.4-intl php7.4-xmlrpc php7.4-soap php7.4-ldap

# Download Extra packages
apt-get install ghostscript poppler-utils graphviz aspell

# Clone Moodle Version from GIT
apt-get install git
git clone --depth 1 --branch $MOODLE_VERSION https://github.com/moodle/moodle.git $MOODLE_PATH
chown -R www-data:www-data $MOODLE_PATH

# Create Moodledata
mkdir $MOODLE_DATA
chown www-data:www-data $MOODLE_DATA

# Move config.php to the installed moodle folder
cp config.php $MOODLE_PATH/config.php

sed -i "s,##DB_DRIVER##,$DB_DRIVER,"     $MOODLE_PATH/config.php
sed -i "s,##DB_HOST##,$DB_HOST,"         $MOODLE_PATH/config.php
sed -i "s,##DB_NAME##,$DB_NAME,"         $MOODLE_PATH/config.php
sed -i "s,##DB_USER##,$DB_USER,"         $MOODLE_PATH/config.php
sed -i "s,##DB_PASS##,$DB_PASS,"         $MOODLE_PATH/config.php
sed -i "s,##DB_PREFIX##,$DB_PREFIX,"     $MOODLE_PATH/config.php
sed -i "s,##DB_PORT##,$DB_PORT,"         $MOODLE_PATH/config.php
sed -i "s,##WWW_ROOT##,$WWW_ROOT,"       $MOODLE_PATH/config.php
sed -i "s,##MOODLE_DATA##,$MOODLE_DATA," $MOODLE_PATH/config.php

# Configure WebService
cp moodle.conf /etc/apache2/sites-available/
#sed -i "s,##MOODLE_PATH##,$MOODLE_PATH," /etc/apache2/sites-available/moodle.conf
#sed -i "s,##MOODLE_WWW##,$MOODLE_WWW,"   /etc/apache2/sites-available/moodle.conf
#service apache2 restart

# Install Moodle
sudo -u www-data php $MOODLE_PATH/admin/cli/install_database.php \
        --lang=$MOODLE_LANG \
        --fullname="$MOODLE_NAME" \
        --shortname="$MOODLE_SHORTNAME" \
        --adminuser=$MOODLE_ADMIN \
        --adminpass=$MOODLE_PASS \
        --agree-license

echo echo "Installation complete admin $MOODLE_PASS"
