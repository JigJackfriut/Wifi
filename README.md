# CloudWifi

A project to create cloud managedenterprise wifi with low cost hardware

# Setup
 1. `sudo apt-get install libmysqlclient-dev`
 2. `bundle update`
 3. `bundle install --gemfile /home/skon/cloudwifi/Gemfile`
 4. `ALTER USER 'root'@'localhost' IDENTIFIED BY 'Kenyon2023`
 5. `rake db:create && rake db:schema:load`
 6. To run automatically: Run `crontab -e`. Then add: `* * * * * /home/skon/cloudwifi/checkpuma.sh`
 7. To run manually (for development): `rails s -b 0.0.0.0 -p _port_`  where _port_ is what you are using (e.g. 3002).




# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
