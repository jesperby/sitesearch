# Site Search

A Ruby on Rails app for the external site search on the City of Malmo and the intranet. Search recommendations are managed in the application. The [siteseeker_normalizer](https://github.com/malmostad/siteseeker_normalizer) Ruby Gem is used for the Siteseeker integration part.

## Dependencies
* nginx (for production)
* Ruby 2.x
* MySQL or PostgreSQL
* ElasticSearch 1.4
* Memcached


## Development Setup

Development dependencies:

* [Vagrant](https://www.vagrantup.com/)
* A Vagrant compatible virtual machine such as VirtualBox or VMWare

To get the project files and create a Vagrant box with a ready-to-use development environment on your own machine, run the following commands:

```shell
$ git clone git@github.com:malmostad/sitesearch.git
$ cd sitesearch
$ vagrant up
```

Check the generated `install_info.txt` file in the project root when the provisioning has finished for database details.

Log in to the Vagrant box as the `vagrant` user and start the application in the Vagrant box:

```shell
$ vagrant ssh
$ cd /vagrant
$ rails s -b 0.0.0.0
```

Point a browser on your host system to http://127.0.0.1:3030. Editing of the project files on your host system will be reflected when you hit reload in your browser.

When you run the `vagrant up` command for the first time it creates an Ubuntu 14.04 based Vagrant box with a ready-to-use development environment for the application. This will take some time. Vagrant will start quick after the first run.


## Server Provisioning

The project contains a standalone Puppet (no master) one-time provisioning setup. Do not run or re-run the provisioning on an existing server if you have made manual changes to config files generated by Puppet. It will overwrite.

On a fresh server running a base install of Ubuntu 14.04:

1. Add `app_runner` as a sudo user.
2. Log on to the server as `app_runner` and download the provisioning files:

        $ wget https://raw.githubusercontent.com/malmostad/puppet-mcommons/master/bootstrap.sh
        $ wget https://raw.githubusercontent.com/malmostad/sitesearch/master/puppet/server.pp

3. Check that the files are OK and start the provisioning:

        $ sudo bash ./bootstrap.sh

4. When finished, read the generated `install_info.txt` file in `app_runner`'s home directory for database details.

Nginx, MySQL, Elasticsearch and memcached are installed as services and configured. Logrotating and database backup is configured. Ruby is compiled and managed using [rbenv](https://github.com/sstephenson/rbenv) for the `app_runner` user.

The user `app_runner` must be used for all build and deployment and for command executions related to the Rails application on the server. Rbenv is configured for that specific user only. Unicorn, the Rack application server, is run by `app_runner`.


## Build and Deployment
Build and deployment is made with Capistrano.

Run the deployment with one of the following commands including the appropriate environment name:

```shell
$ bundle exec cap staging_external deploy
$ bundle exec cap staging_internal deploy
$ bundle exec cap production_external deploy
$ bundle exec cap production_internal deploy
```

## Testing
Run tests before pushing code to the Git repository and before performing deployments. The application contains high level integration/feature tests and unit tests using RSpec, Capybara and PhantomJS. Run the test cases in the projects root directory:

```shell
$ bundle exec rspec
```

## License
Released under AGPL version 3.
