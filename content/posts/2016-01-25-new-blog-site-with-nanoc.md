---
title: "New Blog Site With Nanoc"
created_at: 2016-01-25 15:12:04 +0800
link_to_commits: true
github_username: NicholasTD07
repo: nanoc-blog-site
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

Nanoc is simple to set up and use, and it allows you to pick things you like to
build the site you want, though it could take some time to build your very own
blog/site generator because Nanoc is so generic.

* I can build everything from scratch
* Whitebox

## Getting Started

First you need to have Ruby, Python and Bundler working. Before we run any command in a terminal, put the contents of `Gemfile` and `.gitignore` into them

Gemfile:

```ruby
gem 'nanoc' # Core
gem 'adsf'  # for `nanoc view`
gem 'rake'
gem 'nokogiri'
```

.gitignore:

```
crash.log
tmp/
output/
```

Run `bundle install` to install all the shiny gems!

## Create site with Nanoc

After you have all the gems ready, run `nanoc create-site your-site-name` to
create a site.

To view your site:

* `cd` into your site and type `nanoc` to compile the site.
* Run `nanoc view` to have Nanoc create a server for you to view your site in
a browser.

You can keep the `nanoc view` running while making changes to your site.
However, with every change you make to the site, you will need to run `nanoc`
again. It sounds very repetitive, right? Don't worry. We will be using Guard to
help us automate things.

Commit: #1e2fabe

## Including Helpers

Nanoc provides handy [helpers](http://nanoc.ws/doc/reference/helpers/) for us to
build our site faster. Include the `Blogging, LinkTo, Rendering, Tagging` helpers by placing
a ruby file under `/lib/`(in the root dir of your nanoc site dir) 

```ruby
# nanoc-site/lib/include_helpers.rb
include Nanoc::Helpers::Blogging
include Nanoc::Helpers::LinkTo
include Nanoc::Helpers::Rendering
include Nanoc::Helpers::Tagging
```

Commit: #15c0feb

## Enable Markdown

From Nanoc's official tutorial,
> Nanoc has filters, which transform content from one format into another.

There are predefined filters. It is also very easy to write one by yourself.

### Enable GitHub Flavored Markdown

Add the RedCarpet gem into `Gemfile`.

```ruby
# Gemfile
gem 'redcarpet'

# Remeber to run `bundle` after editing the Gemfile
```

[GitHub Flavored Markdown](https://help.github.com/articles/github-flavored-markdown/)

### Add a Rule for Markdown Files

> The Rules file is used to describe the processing rules for items and layouts.

This is the file that needs to be modified in order to tell Nanoc to use the
redcarpet filter, which is provided by Nanoc.

```ruby
# Rules
compile '/**/*.md' do
  filter :redcarpet
  layout '/default.*'
end
```

> Compilation rules describe how items are processed.

This rule matches items have the `md` extension, and says such items will run
the `redcarpet` filter, followed by laying out the item using the default layout.

### [Write Pages in Markdown](http://nanoc.ws/doc/tutorial/#write-pages-in-markdown)

Get rid of the content in content/index.html (but leave the frontmatter intact), and replace it with Markdown:

```
---
title: "Denis’ Guide to Awesomeness"
---

Now is the time for all good men to come to the aid of their country. This is just a regular paragraph.

## Shopping list

1. Bread
2. Butter
3. Refined uranium
```

Rename the content/index.html file to content/index.md. md is a file extension that is commonly used with Markdown.

Run ``


### Enable Syntax Highlighting for Markdown

To enable syntax highlighting easily, we will need to write a custom filter
which combines the power of [RedCarpet](https://github.com/vmg/redcarpet)
(Markdown -> HTML) and [Pygments](http://pygments.org/) (Master of Syntax
Highlighting).

First install the pygments package with Python's package manager `pip`.

```sh
pip install pygments
```

Then update the `Gemfile` and run `bundle` again.

```ruby
# Gemfile
gem 'pygments.rb'
gem 'nokogiri'
```

#### Custom RedCarpet Filter


### Adding `syntax.css` from Lanyon

* Download [Lanyon](#)
* Move `syntax.css` from `lanyon/public/` to `/content/`
* Add it into `/layouts/default.html`

Because in Jekyll, code blocks are surrounded by a `div.highlight` block but not
in nanoc.

## Use `guard`

```ruby
gem 'guard-nanoc'
gem 'guard-bundler'
gem 'guard-livereload'
```

## Use HAML as Template Language

### Code block

`~ yield` rather than `= yield`
otherwise you will get wrong indentation in code blocks.

### HTML to HAML
Use this http://htmltohaml.com/ to convert HTML into HAML.

### Add Rules

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

## Adopt Lanyon Theme

### CSS Files

* Remove the stylesheet that comes with nanoc itself
* Copy and paste Lanyon's css files into content

### Layouts

* Use [Convert HTML to HAML](http://htmltohaml.com/) to convert HTML templates
  into HAML
* Turn Liquid template statements into HAML

## Extra Bits

### Helper Link to GitHub Commit

### Rake Task: New Post

### Rake Task: Bootstrap blogging environment

## TODOs

### Assets Pipeline

* [  ] Compile css files into one
* [  ] Compile js files into one

## Reference

[Building a static blog with nanoc](http://clarkdave.net/2012/02/building-a-static-blog-with-nanoc/)
