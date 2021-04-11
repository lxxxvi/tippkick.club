# tippkick.club

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
