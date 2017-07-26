##remove and upgrade ruby build plugin##
rm -rf ~/.rbenv/plugins/ruby-build
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build

##upgrade ruby using rbenv##
rbenv install 2.2.1
rbenv global 2.2.1
ruby -v

##bundle##
gem install bundler

##for project##
bundle install


