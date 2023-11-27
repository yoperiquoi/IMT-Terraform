#!/usr/bin/env bash
#
# Install and configure MariaDB for Debian 10.

# Install MariaDB
DEBIAN_FRONTEND=noninteractive apt update -q
DEBIAN_FRONTEND=noninteractive apt install -q -y mariadb-server mariadb-client

# Next line stops mysql install from popping up request for root password
export DEBIAN_FRONTEND=noninteractive
sed -i 's/127.0.0.1/0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf
systemctl restart mysql

# Setup MySQL root password and create a user and add remote privs to app subnet
mysqladmin -u root password ${db_rootpassword}

# Create the wordpress database
cat << EOSQL | mysql -u root --password=${db_rootpassword}
FLUSH PRIVILEGES;
CREATE USER '${db_user}'@'localhost';
CREATE DATABASE ${db_name};
SET PASSWORD FOR '${db_user}'@'localhost'=PASSWORD("${db_password}");
GRANT ALL PRIVILEGES ON ${db_name}.* TO '${db_user}'@'localhost' IDENTIFIED BY '${db_password}';
CREATE USER '${db_user}'@'%';
SET PASSWORD FOR '${db_user}'@'%'=PASSWORD("${db_password}");
GRANT ALL PRIVILEGES ON ${db_name}.* TO '${db_user}'@'%' IDENTIFIED BY '${db_password}';
EOSQL
