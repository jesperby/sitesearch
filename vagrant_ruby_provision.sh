#!/usr/bin/env bash

echo User `whoami` is provisioning

function install {
    echo installing $1
    shift
    apt-get -y install "$@"
}

echo Installing rbenv from Git repo
git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build

echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
# Vagrant shell can't source?
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

echo Installing Ruby version as specified in project
RUBY_VERSION=`cat /vagrant/.ruby-version`
rbenv install $RUBY_VERSION
rbenv global $RUBY_VERSION
rbenv rehash

echo Installing Bundler
gem install bundler

echo Configuring Rails environment ...
cd /vagrant

echo Installing gems
bundle install

echo Migrating database
bundle exec rake db:migrate
RAILS_ENV=test bundle exec rake db:migrate

echo 'Creating ElasticSearch indices (404 is expected)'
RAILS_ENV=development bundle exec rake environment elasticsearch:reindex CLASS='Recommendation' ALIAS='recommendations'
RAILS_ENV=test bundle exec rake environment elasticsearch:reindex CLASS='Recommendation' ALIAS='recommendations_test'