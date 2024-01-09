# rmagick

## Error while starting the rails server
`Gem Load Error is: This installation of RMagick was configured with ImageMagick ... but ImageMagick ... is in use.`

#### How to fix?

-> reinstall rmagick gem (`gem uninstall rmagick` && `gem install rmagick`)

If building native extension fails (something like `ERROR: Failed to build gem native extension.`):
- `brew install imagemagick@6 && brew link imagemagick@6 --force` (maybe unlinking beforehand is also needed: `brew unlink imagemagick`)
- afterwards run `gem install rmagick` again



## Rmagick Broken: Library not loaded
Rmagick says it's broken, for example, after upgrading to a new MacOS version.

` Referenced from: /Users/xyz/.rvm/gems/ruby-2.4.0@nc/gems/rmagick-2.16.0/lib/RMagick2.bundle
  Reason: image not found`

#### How to fix?
`gem pristine rmagick`
