# Email & Weblinks in iOS Mailclients

## Context

Developing html emails

## Problem

iOS devices, by default, will style all your links blue and underline them.

Links include anything with `www`, `.de`, `.com` and also email addresses, telephone numbers and addresses.

**Note:** You must try this out on your iOS and Mac device by sending the email to yourself. This problem does not appear on action mailer previews, desktop previews, or letter opener. Also try out different mail clients like Apple Mail and the Gmail app.

## How to fix it

If you're developing your emails with ruby on rails, simply use rails helpers like `link_to`, `mail_to` and a class to style the link in your email templates. This works for mobile and desktop devices.

* mail_to
```
p
  = t('devise.mailer.invitation_instructions.hello')

  = mail_to @resource.email do
    span.link-green.margin-small
      = @resource.email
```

* link_to
```
p
  = link_to root_url, root_url, class: 'link-green'

  = link_to 'www.conlance.de', 'https://www.conlance.de', class: 'link-green', target: '_blank'

  = raw t('devise.mailer.invitation_instructions.someone_invited_you', url: link_to(root_url, root_url, class: 'link-green'))

```

* app/views/layouts/mailer.html.slim
```
doctype html
html
  head
    style
      .link-green
        color: #82B500
        text-decoration: none

      .margin-small
        margin-left: 3px

  body
    = yield
```

## Helpful links

Here are some links with possible solutions (not ruby on rails specific):

* https://help.litmus.com/article/207-removing-blue-links-on-ios-devices

* https://stackoverflow.com/questions/49816588/blue-links-issue-on-gmail-and-ios-email-clients

* https://www.litmus.com/blog/update-banning-blue-links-on-ios-devices-2/

Good luck! :four_leaf_clover:
