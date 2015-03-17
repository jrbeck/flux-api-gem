# Flux Api Gem [![Build Status](https://travis-ci.org/metova/flux-api-gem.svg?branch=develop)](https://travis-ci.org/metova/flux-api-gem)

## Prerequisites

* Flux Application ID and Secret
* Flux user for your application

## Usage

Create your Flux Application ID and Secret, then use those to build the Flux Client:

```ruby
Flux::Client.new('flux_app_id', 'flux_app_secret', 'metova')
```

To access flux resources on behalf of your application, call `application` on your client:

```ruby
@client.application
```

You can then use the following methods on the client application:

```ruby
application.users                             # list all users visible to the application
application.accounts                          # list all accounts
application.products                          # ...
application.projects
application.account_links
application.metadata([1, 2, 3])               # get the metadata associated with some projects (pass an array of project ids)
application.metadata=(1, { some: 'value' })   # set the metadata for a project
```

You can also operate on behalf of a user if you have a token for that user (ie: they signed in to your site with their FluxID):

```ruby
@client.user('a_valid_token_string')
@client.user(a_valid_token_object)
```