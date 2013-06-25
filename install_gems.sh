if [[ ! $(gem list | grep bundler) ]]; then
  gem install bundler -v 1.0.21
fi
bundle install --local --without development
if [[ $RESULT -ne 0 ]]; then
  echo bundle installation failed, quitting
  exit $RESULT
fi


