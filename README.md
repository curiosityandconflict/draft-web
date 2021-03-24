# Getting Started

## Requirements
* install ruby on rails: http://www.installrails.com/

## Up and Running
* from the project folder, run `bundle install`
* and `yarn install`
* then run `rail s`
* go to `localhost:3000` in your browser


## Test Emails Locally
* setup and account on https://mailtrap.io
* from the terminal, run `rails credentials:edit --environment development`
* add the following:
```
mailer:
  address:
  domain:
  port:
  username:
  password:
  authentication:
```
