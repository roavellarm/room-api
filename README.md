# Room Api

[![CircleCI](https://circleci.com/gh/roavellarm/room-api.svg?style=svg)](https://circleci.com/gh/roavellarm/room-api)
[![Maintainability](https://api.codeclimate.com/v1/badges/a8ff1d48acb81616a666/maintainability)](https://codeclimate.com/github/roavellarm/room-api/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/a8ff1d48acb81616a666/test_coverage)](https://codeclimate.com/github/roavellarm/room-api/test_coverage)


![meeting room](https://raw.githubusercontent.com/roavellarm/room-web/master/public/images/meeting-room.jpg)

This is the API of the Room project which is a web application that aims to improve the interaction experience of remote workers.

You can get the [frontend](https://github.com/roavellarm/room-web), the [Endpoints documentation](https://github.com/roavellarm/room-api/blob/master/schema/api.md) and the [MVP Process Documentation](https://github.com/roavellarm/room-doc/blob/master/README.md) on github.

Check the work in progress application <a href="https://room-web.netlify.com/" target="_blank">here</a>.


## Installation (Standalone)

#### 1. Install PostgreSQL

[PostgreSQL](http://postgresql.org/)

#### 2. Install Rbenv

Rbenv: [repo](https://github.com/rbenv/rbenv)

- Check that the rbenv PATH is configured correctly, according to the repo instructions.

#### 3. Install Rbenv-gemset

Rbenv-gemset: [repo](https://github.com/jf/rbenv-gemset)

#### 4. Install and set Ruby

```
$ rbenv install 2.5.5
$ rbenv global 2.5.5
```

#### 5. Install last Node version & MJML package
```
$ curl -sL https://deb.nodesource.com/setup_12.x | bash -
$ apt-get install -y nodejs && npm install -g mjml
```

If rbenv complains you don't have that ruby version, upgrade [ruby-build](https://github.com/rbenv/ruby-build#readme).

#### 6. Clone the repository & update git remote

```
$ git clone git@github.com:roavellarm/room-api.git
$ cd <identifier_name>
```

#### 7. `.env` and local variables

You must have the correct `.env` variables.
There is values there that we CANNOT send to the github, otherwise this will
represent a secutiry flaw. If you're using Docker you also need to change
some values like `POSTGRES_HOST` (if you use Docker, you should know the values).

```
$ cp .env.sample .env
```

#### 8. Install project dependencies

```
$ bin/bundle
```
Always use this command to ensure the gems are installed in `.gems`.

#### 9. Prepare the database

```
$ bin/rails db:create db:migrate db:seed
```

#### 10. Running the server

```
$ bin/rails s
```

You can check that it worked by browsing `localhost:3000`.

## Using MJML Mailer templates

In order to use that, ALL mailer views should end in `.mjml` extensions, and can be used both for MJML
AND for ERB views. Example: `my_mailer.html.erb` will be converted in `my_mailer.mjml` and will
continue to have all traditional features of ERB files, including support for embedded Ruby lines.

In other words, you can write both HTML and Ruby code inside this mailers.
Once you have written your template, MJML Rails Gem will automatically convert this file into HTML, and will try at max to make it responsible even for mobile screens.

The documentation for MJML templates can be found [HERE!!!!](https://mjml.io/).

## Tests/Specs

#### Running RSpec

```
$ bin/rspec
# OR for Docker
$ docker-compose run rails bin/rspec
```

The coverage will be available on the `coverage/` folder. Open `coverage/index.html` on your browser to see details.

#### Running the linter

```
$ bin/rubocop
# OR for Docker
$ docker-compose run rails bin/rubocop
```

## Docker help section

### Build the container for the project

```
$ docker-compose build

options:
--no-cache (build the entire container using no cached infos)
```

### Running the project

```
$ docker-compose up
```

### Listing running containers

```
$ docker ps

This command will show the running containers, example:

CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                    NAMES
dfb80bf0ae96        postgres:10.4       "docker-entrypoint.s…"   3 hours ago         Up 3 hours          0.0.0.0:5432->5432/tcp   new-rails-api_postgres_1
```

### Running commands using docker-compose

```
$ docker-compose run [container name] [command]

example:

$ docker-compose run rails bin/rails db:create
```

### Running commands on a running container

```
$ docker exec [options] [container ID] [command]

options:

-i (interactive)
-t (attach terminal to command)

examples:

$ docker exec -it dfb80bf0ae96 bin/rails db:migrate
```

The `dfb80bf0ae96` string here is shown when you run `docker ps`. This is the container ID running on your machine.

## Deployment

### Setup

- Create a one Heroku project for Staging and another one for Production.
- Inside Heroku Apps you should add the NodeJS buildpacks (for MJML mailer templates)
  - `heroku buildpacks:add --index 1 heroku/nodejs`
- Configure the `RAILS_MASTER_KEY` env var for both heroku projects (they are the same).
- Check app names at `.circleci/config.yml` to see if they match the names on Heroku dashboard

#### Production and Staging

The URLs for production and staging are:

- https://staging-room-api.herokuapp.com/
- https://production-room-api.herokuapp.com/

### Staging

All commits to `master` branch will be pushed to staging by CircleCI.

### Production

Generate a new release - all tags in the format `vX`, where `X` is an integer, will be automatically pushed to production.

Example: `v1`, `v2` ... `v10` and so on.


## Create a new Service Object with generator

```
  bin/rails generate "service_object_name"
```

This command generates the service object template and a test template for Rspec.
