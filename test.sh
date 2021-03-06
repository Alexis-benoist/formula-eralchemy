brew update
rm -f /usr/local/Library/Formula/eralchemy.rb
cp ~/dev/formula-eralchemy/eralchemy.rb /usr/local/Library/Formula/eralchemy.rb
brew uninstall eralchemy
brew install eralchemy --build-from-source --with-postgresql
brew test eralchemy
brew audit --strict --online eralchemy
