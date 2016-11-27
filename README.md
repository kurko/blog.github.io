# blog

1. run `bundle exec jekyll serve`
2. Visit `localhost:4000`

## Post images

Images for posts should be located under `_posts/images/`. During build time
those images are copied over to `_site/images` (see [the
plugin](_plugins/post_images.rb)).

## Deploys

Use `bin/deploy` from the master branch to deploy.

**Caveat:** when in the gh-pages branch, `JEKYLL_ENV` will be ignored by Jekyll.
To be able to use that, during deploy we go to `deploy-custom-html` branch and
build the HTML there. Then we merge that into `gh-pages`. The binary file
handles all that automatically.
