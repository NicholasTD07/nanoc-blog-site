---
title: "new-blog-site-with-nanoc"
created_at: 2016-01-25 15:12:04 +0800
kind: article
---

<!-- more -->

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

### Including Blogging helpers

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

### Use `guard`

```ruby
gem 'guard-nanoc'
gem 'guard-bundler'
gem 'guard-livereload'
```

### Use HAML as Template Language

#### Code block

`~ yield` rather than `= yield`
otherwise you will get wrong indentation in code blocks.

#### HTML to HAML
Use this http://htmltohaml.com/ to convert HTML into HAML.

#### Add Rules

```rb
compile '/**/*.haml' do
  filter :haml
  layout '/default.*'
end
```

```diff
- route '/**/*.{html,md}' do
+ route '/**/*.{html,md,haml}' do
```

### Adopt Lanyon Theme

#### CSS Files

* Remove the stylesheet that comes with nanoc itself
* Copy and paste Lanyon's css files into content

#### Layouts

* Use [Convert HTML to HAML](http://htmltohaml.com/) to convert HTML templates
  into HAML
* Turn Liquid template statements into HAML

### Extra Bits: Rakefile

#### Task: New Post

#### Task: Bootstrap blogging environment

## TODOs

### Assets Pipeline

* [  ] Compile css files into one
* [  ] Compile js files into one

## Reference

[Building a static blog with nanoc](http://clarkdave.net/2012/02/building-a-static-blog-with-nanoc/)
