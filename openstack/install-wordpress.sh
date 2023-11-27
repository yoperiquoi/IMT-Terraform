#!/usr/bin/env bash
#
# Install and configure Apache to serve Wordpress for Debian 10.

apt-get update -y
apt-get upgrade -y
apt-get install -q -y --force-yes wordpress apache2 curl lynx

cat << EOF > /etc/apache2/sites-available/wp.conf
Alias /wp/wp-content /var/lib/wordpress/wp-content
Alias /wp /usr/share/wordpress
<Directory /usr/share/wordpress>
    Options FollowSymLinks
    AllowOverride Limit Options FileInfo
    DirectoryIndex index.php
    Require all granted
</Directory>
<Directory /var/lib/wordpress/wp-content>
    Options FollowSymLinks
    Require all granted
</Directory>
EOF

a2ensite wp
service apache2 reload

cat << EOF > /etc/wordpress/config-default.php
<?php
define('DB_NAME', '${db_name}');
define('DB_USER', '${db_user}');
define('DB_PASSWORD', '${db_password}');
define('DB_HOST', '${db_host}');
define('WP_CONTENT_DIR', '/var/lib/wordpress/wp-content');
?>
EOF
