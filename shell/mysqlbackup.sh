#MYSQL BACKUP SCRIPT
file_name="mysqlbackup"
today=$(date "+%Y%m%d")
path=/host-rootfs/sdcard/mysqlbackup/
dbuser=root
dbpass=mysql0202!

# MYSQL DUMP
mysqldump --all-databases -u $dbuser -p $dbpass > $path/$file_name-$today.sql