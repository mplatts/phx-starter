# Setup
## ENV
Add env vars

## Email
Create mailgun account
Set env vars
In `pow_mailer.ex` set the "from" address.

## SEO / Analytics
in `_head.html.eex`
Add title/description

## Images
Add in static/images/
for-open-graph.png
logo.png
favicon.png

# Deploy


# App

## Login
Users won't be signed in when they register, and can't sign in until the e-mail has been confirmed. The confirmation e-mail will be sent every time the sign in fails. 



# To Test

- register
- sign in
- reset password
- remember me