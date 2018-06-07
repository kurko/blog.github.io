# blog

## Run

1. run `bundle exec jekyll serve`
2. Visit `localhost:4000`

## Deploy

Page is served from branch `gh-pages`. That branch is generated automatically,
so don't touch it. The process should go like this:

1. make changes you want to `master`
2. commit to `master`
3. run `./bin/deploy`
4. done

## Post images

Images for posts should be located under `_posts/images/`. During build time
those images are copied over to `_site/images` (see [the
plugin](_plugins/post_images.rb)).
