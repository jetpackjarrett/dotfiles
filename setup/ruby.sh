echo 'Setting up rbenv and installing Rails...'

rbenv install 2.1.2
rbenv global 2.1.2

# Install Rails
gem install rails
rbenv rehash
