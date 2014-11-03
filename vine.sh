# The ouput of all these installation steps is noisy. With this utility
# the progress report is nice and concise.
function install {
echo installing $1
shift
apt-get -y install "$@" >/dev/null 2>&1
}
apt-get -y install libsqlite3-dev

echo updating package information
apt-add-repository -y ppa:brightbox/ruby-ng >/dev/null 2>&1
apt-get -y update >/dev/null 2>&1

install 'development tools' build-essential

install Ruby ruby2.1 ruby2.1-dev
update-alternatives --set ruby /usr/bin/ruby2.1 >/dev/null 2>&1
update-alternatives --set gem /usr/bin/gem2.1 >/dev/null 2>&1

echo installing Bundler
gem install bundler -N >/dev/null 2>&1
gem install vines vines-agent vines-services
#vines-services init wonderland.lit

echo installing vine


echo 'all set, rock on!'
