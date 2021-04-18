[![Maintainability](https://api.codeclimate.com/v1/badges/387e31f23babd44f0951/maintainability)](https://codeclimate.com/github/lxxxvi/tippkick.club/maintainability)

# tippkick.club

## Prerequisite

Make sure you have these dependencies installed and running:

* Postgres
* Redis

## Local setup

Clone the repository, then

```
bin/setup
```

### Seeds

Seeds contain initial data for

* Team (Global Team)
* Games (UEFA Euro 2020)
* User (Admins)

```
bin/rails db:seed
```

### Fixtures

Alternatively you can load the test fixtures, which contains multiple users, their bets, some game results, teams etc.

```
bin/rails db:fixtures:load
```

### Even more data

If you want even more data, you can use

```
bin/rails dev:setup
```

which loads the fixtures (same as described above), and adds some more **random** data (users, teams).

## Test locally

To run the entire test suite, use:

```
bin/test
```

Which calls

* `bin/rails test`
* `bin/rails test:system`
* `bundle exec rubocop`


## Heroku Setup

Node

```
heroku buildpacks:add heroku/nodejs
heroku buildpacks:add heroku/ruby
```

```
heroku addons:create heroku-redis:hobby-dev
```

## Run production locally

```
RAILS_ENV=production NODE_ENV=production bin/rails assets:precompile
```

```
RAILS_SERVE_STATIC_FILES=true bin/rails s -e production
```
