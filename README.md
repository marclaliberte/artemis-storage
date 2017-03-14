#Artemis - Storage

A dockerized image for the Artemis storage server.

### Usage

Download latest container for storage server and mysql

 ```
 docker pull marclaliberte/artemis-storage
 docker pull mysql/mysql-server
 ```

Create user-defined Docker network

 ```
 docker network create artemis
 ```

Mount mysql container exposing ports and setting name to 'mysql-database'
 ```
 docker run --name mysql-database -p 3306:3306 -e MYSQL_ROOT_PASSWORD=[MySQLPassword] -d mysql
 ```
Mount storage server container and link to mysql-database

 ```
 docker run --name artemis-storage --link mysql-database:mysql -it artemis-storage
 ```

Within the container, edit hpfeeds and mysql settings in config.cfg
 ```
 vim config.cfg
 ```

Within the container, start the storage server
 ```
 python artemis.py start
 ```
