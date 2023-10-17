# sequel-sequence-demo
Skeleton of a `Roda`-based application with `Sequel` using the `sequel-sequence` Gem.
It's the platform for experiments in the design of microservices using the sequence-sequence gem

## 1. Database Setup
### 1.0. Preparing the digital environment
Create `.env`, `.env.development`, `.env.test` files from their samples.
Prepare PostgreSQL, MySQL, MariaDB and SQLite.

If you would like, you can add a containerized RDBMS to the system.
```bash
docker compose up
```
Three DBMS will be installed in the containers (PostgreSQL, MySQL and MariaDB).

Do the DBMS setup before launching the application.

### 1.1. Setting up PostgreSQL database
Login to pgAdmin on `localhost:5050`. Please enter your master password, then add a server with the following attributes: 
```bash
name: postgres_container
host: host.docker.internal
port: 5437
database: postgres
user: postgres
password: postgres
```
Сreate databases `sequel_sequence_demo_development` and `sequel_sequence_demo_test` from the pgAdmin UI.

### 1.2. Setting up MySQL database
Take the host IP adress using command:
```bash
docker inspect mysql_container
```
Find the line with `IPAddress`. It myght be look like this one - `"IPAddress": "172.23.0.3"`

Login to phpmyadmin on `localhost:8080` with the following attributes:
```bash
host: 172.23.0.3
user: root
password: rootroot
```
Create databases `sequel_sequence_demo_development` and `sequel_sequence_demo_test` from the phpmyadmin UI.

### 1.3. Setting up MariaDB database
Аollow the steps of the item 1.2. Settings for MySQL database
Take the host IP adress using command:
```bash
docker inspect mariadb_container
```
Definitely Login to phpmyadmin on `localhost:8081` with the following attributes:
```bash
user: root
password: rootroot
```

### 1.4. Setting up SQLite database
It's assumed that SQLite is installed locally.
Add SQLite databases:
```bash
$ touch data/sqlite/sequel_sequence_demo_development.sqlite3
$ touch data/sqlite/sequel_sequence_demo_test.sqlite3
```

## 2. Application environment setup
Select DB_ADAPTER= in .env file

Uncomment a string containing only one Gem for the selected database, corresponding to the DB_ADAPTER. Be careful, you can only make one choice at a time.
```ruby
# gem 'mysql2'
# gem 'sequel_pg', require: 'sequel'
# gem 'sqlite3'
```
Gem 'mysql2' is for mysql or mariadb, gem 'sequel_pg' – for postgresql, and gem 'sqlite3' – for SQLite database.

Run:
```bash
$ bundle install
```
Add migrations 
$ rake dev_up  
$ rake test_up 

Open console `bin/console` to get experience with `'sequel-sequence'` GEM API! 
For example:
```ruby
DB.custom_sequence?(:label)
pp DB.check_sequences
DB.nextval("label")
DB.currval("label")
DB.lastval("label")
DB.setval("label", 1234)
DB.nextval_with_label(:label, 1) # output depends on RDNMS

# test set_column_default_nextval
item1 = Item.create(name: 'Suitable')
item2 = Item.create(name: 'Fateful')
DB.nextval("article")
DB.currval("article")
```

## 3. Another usefull commands
### 3.1. Run the App
```bash
$ bin/puma
```
or run the application with modified configuration using environment variables as well
```bash
$ RACK_ENV=test bin/puma
```

### 3.2. HealthCheck of HTTP-requests to the app
Use the URL port setting in `config/puma.rb` to manage multiple microservices in the same environment.
```bash
$ curl --url "http://localhost:3000" -v
$ http :3000
```

### 3.3. Run tests
```bash
$ bin/rspec
```

### 3.4. Additional tips
1. Use a timestamp for the new migration filename:
```bash
$ date -u +%Y%m%d%H%M%S
```
2. After adding additional migration files, you can run the migrations:
```bash
$ rake dev_up  
$ rake test_up 
$ rake prod_up 
```
3. After modifying the migration file, you can drop down and then back up the migrations with a single command:
```bash
$ rake dev_bounce  
$ rake test_bounce 
```
4. Roll back database migration all the way down:
```bash
$ rake dev_down  
$ rake test_down 
$ rake prod_down 
```
5. Feed the database with initial data from the file `db/seeds`:
```bash
$ rake dev_seed
$ rake test_seed
$ rake prod_seed
```
6. The list of all tasks is called by the command:
```bash
$ bin/rake --tasks
```
7. Making a database's schema dump and [other manipulations](https://sequel.jeremyevans.net/rdoc/files/doc/bin_sequel_rdoc.html) from the command line interface
```bash
$ bin/sequel -d postgres://user:pass@host/database_name
$ bin/sequel -D postgres://user:pass@host/database_name
```

## Author:
* it.Architect https://github.com/Oreol-Group/
