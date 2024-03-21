# Upgrading sprockets from 3.x to 4.x

Check this out if you get errors like this (after successfully starting puma and trying to open a page):

![sass_error](/_src/sass_1.png)

Citing the [official upgrade guide](https://github.com/rails/sprockets/blob/master/UPGRADING.md) here:

> If you are using sprockets **prior to 4.0**, Rails will compile application.css, application.js; and any files found in your assets directory(ies) that are not recognized as JS or CSS, but do have a filename extension.

> If you are **using Sprockets 4**, Rails changes it's default logic for determining top-level targets. It will now use only a file at ./app/assets/config/manifest.js for specifying top-level targets; this file may already exist in your Rails app (although Rails only starts automatically using it once you are using sprockets 4), if not you should create it.

The files which probably have to be changed are: `app/assets/config/manifests.js` and `config/initializers/assets.rb`.
