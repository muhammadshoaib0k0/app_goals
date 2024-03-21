# Content Security Policy (CSP)

## What is a CSP?
"The HTTP Content-Security-Policy response header allows web site administrators to control resources the user agent is allowed to load for a given page. With a few exceptions, policies mostly involve specifying server origins and script endpoints. This helps guard against cross-site scripting attacks (XSS)." - [mozilla.org](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Security-Policy)

A Content Security Policy allows us to control resource origins for scripts, styles, fonts and more.

## When you should use it?
It's generally always a good idea to enable the CSP. It improves the application security.

## How to implement it?
Rails already provides us with the `content_security_policy.rb`, but the content is usually out-commented and you have to enable the policy by yourself.

- Go to `config/initializers/content_security_policy.rb`
- Un-comment the `Rails.application.config.content_security_policy do |policy|` block.
- Define the policies as strict as possible at the beginning, then add exceptions etc. necessary for your app
- restart the server when you modify this file

## Basic Policy Example
Basic Policy that only allows for self hostet resources:
```
Rails.application.config.content_security_policy do |policy|
  policy.default_src :self
  policy.font_src    :self
  policy.img_src     :self
  policy.object_src  :none
  policy.script_src  :self
  policy.style_src   :self
  # If you are using webpack-dev-server then specify webpack-dev-server host
  policy.connect_src :self, :https, "http://localhost:3035", "ws://localhost:3035" if Rails.env.development?
end
```

Example with some exceptions:
```
Rails.application.config.content_security_policy do |policy|
  policy.default_src :self, :https
  policy.font_src    :self, "https://www.provenexpert.com"
  policy.img_src     :self, :https, :data
  policy.object_src  :none
  policy.script_src  :self, :https, "http://www.googletagmanager.com"
  policy.style_src   :self, :https

  policy.connect_src :self, :https, "http://localhost:3035", "ws://localhost:3035" if Rails.env.development?
end
```

## Additional tips
If you are not sure whitch sources to allow, you can disallow everything and then check in your browser console which sources failed to load for your application.
Then you can allow specifically the sources that your application try to load. You may check every site of your app if you have resources that are only loaded on specific sites.

Test your application with all environments (especially prod setting) to be sure that you allowed all necessary sources. If you have for example inline scripts that only appear in a productive environment and you didn't allow `:unsafe_inline` (try to avoid `:unsafe_inline`) you may expirience some bugs.

When everyting is set-up use a browser tool to check on your setup, for example [CSP Evaluator](https://chrome.google.com/webstore/detail/csp-evaluator/fjohamlofnakbnbfjkohkbdigoodcejf) for Chrome.

## Projects with enabled CSP
- [conlance website](https://gitlab.conlance.org/conlance/website_new)

## Resources
https://edgeguides.rubyonrails.org/security.html#content-security-policy

https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Security-Policy

https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Security-Policy-Report-Only
