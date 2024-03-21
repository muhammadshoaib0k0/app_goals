# ruby setup

## rbenv
Install rbenv (ruby version-manager)
```
  brew install rbenv
```
Put this in your bash-profile for setting up rbenv in your shell automatically:
```shell
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
  export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"
```
#### usage:
- install ruby-versions with: `rbenv install 2.4.0`
- switch the global ruby version with: `rbenv global 2.1.5`
- set the local ruby version with: `rbenv local 2.3.0`
- rbenv will also check the file `.ruby-version` in your current directory
- [more information](https://github.com/rbenv/rbenv)

#### further notes:
If you install a new ruby version, you'll have to reinstall your basic gems (mostly it will be bundler, rails, rubocop). You can do this manually (`gem install bundler`) or use [rbenv-default-gems](https://github.com/rbenv/rbenv-default-gems). With this you can specify your default gems, which then will be installed automatically after each ruby installation.

## Trouble-shooting
### gem installation errors
#### "You don't have write permissions...""
```
Fetching: concurrent-ruby-1.0.5.gem (100%)
ERROR: While executing gem … (Gem::FilePermissionError)
You don’t have write permissions for the /Library/Ruby/Gems/2.3.0 directory.
```

How to fix?
- don't install gems with sudo!
- probably rbenv is not set up properly, so put this inside your bash-profile (most of us use zsh, so it would be ~/.zshrc):
```shell
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"
```
- you can check your gem path with `gem env home`, which should look like this: `/Users/your-user/.rbenv/versions/2.1.5/lib/ruby/gems/2.1.0`
