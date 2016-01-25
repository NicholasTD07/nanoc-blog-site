---
title: "new-blog-site-with-nanoc"
created_at: 2016-01-25 15:12:04 +0800
---

## Steps

### Gemfile

* nanoc
* adsf
* rake
* kramdown
* pygments.rb

* nokogiri

### .gitignore

* crash.log
* tmp/
* output/

### Create site with nanoc

``

### Enable Markdown in `Rules`

#### Enable Kramdown to take GitHub Flavor Markdown

#### Enable Syntax Highlighting for Markdown

`colorize_syntax`

#### Adding `syntax.css` from Lanyon

* Download [Lanyon](#)
* Move `syntax.css` from `lanyon/public/` to `/content/`
* Add it into `/layouts/default.html`
* Replace all `.highlight` to `code` in `syntax.css`

Because in Jekyll, code blocks are surrounded by a `div.highlight` block but not
in nanoc.


### Adopt Lanyon Theme

#### Including Blogging helpers

#### Rewriting `index.html`


### Extra Bits: Rakefile

#### Task: New Post

#### Task: Bootstrap blogging environment

## TODOs

### Assets Pipeline

* [  ] Compile css files into one
* [  ] Compile js files into one

## Reference

[Building a static blog with nanoc](http://clarkdave.net/2012/02/building-a-static-blog-with-nanoc/)
