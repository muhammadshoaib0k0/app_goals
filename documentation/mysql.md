# MySQL

## How to install an old version of MySQL?

```shell
brew install mysql@5.7
```

## mysql2 Gem Installation Errors

### library not found for -lssl

```
# [...]
compiling result.c
linking shared-object mysql2/mysql2.bundle
ld: library not found for -lssl
clang: error: linker command failed with exit code 1 (use -v to see invocation)
make: *** [mysql2.bundle] Error 1
# [...]
```

#### How to fix?

```shell
brew install openssl

bundle config build.mysql2 --with-opt-dir=$(brew --prefix openssl)
bundle install
```

### On Mojave: Failed to build gem native extension

```
ERROR: Failed to build gem native extension

# [...]

Could not create Makefile due to some reason, probably lack of
necessary libraries and/or headers.

# [...]

The compiler failed to generate an executable file. (RuntimeError)
You have to install development tools first.
```

#### How to fix on Mojave?
Install or update Xcode. If mysql gem installation still doesn't work, open a new terminal tab and run:
```shell
cd  /Library/Developer/CommandLineTools/Packages/
open macOS_SDK_headers_for_macOS_10.14.pkg
```

## Reinstalling mysql2

You might want to do this, if you upgraded to a new MacOS version and mysql doesn't work in the projects anymore.

(And before the MacOS upgrade everything was fine & the above Mojave fix doesn't work)

### Remove MySQL completely <sup>1</sup>
```
brew remove mysql
brew cleanup
sudo rm /usr/local/mysql
sudo rm -rf /usr/local/var/mysql
sudo rm -rf /usr/local/mysql*
sudo rm ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist
sudo rm -rf /Library/StartupItems/MySQLCOM
sudo rm -rf /Library/PreferencePanes/My*
sudo rm -rf /Library/Receipts/mysql*
sudo rm -rf /Library/Receipts/MySQL*
sudo rm -rf /private/var/db/receipts/*mysql*
launchctl unload -w ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist
```
- restart your computer to make sure that any MySQL processes are killed
- try to run `mysql` , it should not work

### Install with homebrew <sup>1</sup>
```
brew doctor and fix any errors
brew update
brew install mysql
unset TMPDIR
mysql_secure_installation (the command brew suggests)
```
### In your project <sup>2</sup>
```
cd your_mysql_project
gem uninstall mysql2
bundle update mysql2
```
- in the gemfile, you might need to update the mysql version, for example `gem 'mysql2', '~> 0.4.10'`
```
mysql.server start
rails db:create
rails db:seed
rails db:migrate
```

<sup>1</sup>
[source](https://coderwall.com/p/os6woq/uninstall-all-those-broken-versions-of-mysql-and-re-install-it-with-brew-on-mac-mavericks)

<sup>2</sup> thanks to tobias
