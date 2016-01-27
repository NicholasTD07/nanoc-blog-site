---
title: "New Blog Site With Nanoc"
created_at: 2016-01-25 15:12:04 +0800
kind: article
---

Spent about a day to make this **shinny** new blog site with [Nanoc](http://nanoc.ws/) and some other open source tools.

Summary:

* [Nanoc](http://nanoc.ws/) as static site generator
* [HAML](http://haml.info/) as template engine
* [Lanyon](http://lanyon.getpoole.com/) as the theme you are seeing right now
* [Guard](https://github.com/guard/guard) for regenerating site and live-reloading browser
* [Rake](https://github.com/ruby/rake) for manging tasks
* [GitHub Flavored Markdown](https://help.github.com/articles/github-flavored-markdown/) for writing blogs

Wanna know how this fantastic blog came alive?

<!-- more -->

## Why Nanoc?

Nanoc is simple to set up and use, and it allows you to pick things you like to build the site you want, though it could take some time to build your very own blog/site generator because Nanoc is so generic.

* I can build everything from scratch
* Whitebox

## Steps

First you need to have Ruby and Bundler working.

### Gemfile

```ruby
gem 'nanoc' # Core
gem 'adsf'  # for `nanoc view`
gem 'rake'
gem 'nokogiri'
```

### .gitignore

* crash.log
* tmp/
* output/

### Create site with nanoc

``

### Including Blogging helpers

### Enable Markdown in `Rules`

#### Enable Kramdown to take GitHub Flavor Markdown

Gem
* kramdown

#### Enable Syntax Highlighting for Markdown

Gem
* pygments.rb

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
