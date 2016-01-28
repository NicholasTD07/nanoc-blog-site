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
* [Pygments](http://pygments.org/) for syntax highlighting
* [GitHub Flavored Markdown](https://help.github.com/articles/github-flavored-markdown/) for writing blogs

Wanna know how this fantastic blog came alive?

<!-- more -->

## How to Use This Blog Site as a Template for Your Site(s)

Setup:

```sh
rake b # b for bootstrap
# It installs the dependencies with `pip` and `bundle`
# See Rakefile for more details

# DONE! That's all.
```

Usage:

* Use `rake new[post-name]` to create new posts in `content/posts/`
* Run `bundle exec guard` to re-gen the site when there's any change to the source of the site
* Run `nanoc view` to create a local server which serves the generated site

## Why Nanoc?

Nanoc is simple to set up and use, and it allows you to pick things you like to
build the site you want, though it could take some time to build your very own
blog/site generator because Nanoc is so generic.

* Nanoc is very flexible
* Nanoc is easy to be extended
* I can build everything from scratch
  * I know this site and its source code inside out
* Jekyll (previous static generator powering my blog) is a black box to me
  * Complex
  * Hard to tweak
  * Code, written by other people, to read

## Getting Started

First you need to have Ruby, Python and Bundler working.

Make a directory for your site.
I like to do it in command line `mkdir your-site-name`. You can do it anyway you
like. `cd` into your site in your terminal/command-line.


Before we run any command in a terminal, put the contents of `Gemfile` and
`.gitignore` into them respectively (in the newly created directory).

Gemfile:

```ruby
gem 'nanoc' # Core
gem 'adsf'  # for `nanoc view`
gem 'rake'
gem 'nokogiri'
```

.gitignore:

```sh
# If you use git for version control,
# otherwise you don't need this.
crash.log
tmp/
output/
```

Run `bundle install` to install all the shiny gems. Let's start the party!

## Create a Site with Nanoc

After you have all the gems ready, run `nanoc create-site . -f` to
create a site while you are in the site directory. `-f` is needed because the
directory already exists.

To view your site:

* Type `nanoc` to compile the site.
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
a ruby file under `lib/`(in the root dir of your nanoc site dir) 

```ruby
# nanoc-site/lib/include_helpers.rb
include Nanoc::Helpers::Blogging
include Nanoc::Helpers::LinkTo
include Nanoc::Helpers::Rendering
include Nanoc::Helpers::Tagging
```

> Files in the `lib`/ directory are loaded alphabetically. This can cause Nanoc to try to include a helper before it is loaded.

Read more: [Pitfall: helper load order](http://nanoc.ws/doc/helpers/#pitfall-helper-load-order)


Commit: #15c0feb

## Enable Markdown

Commit: #a38e3e1

~~I took a detour in the commit above because I was using kramedown for the
Markdown parser. If you find unrelated changes in that commit, that's it.~~

From Nanoc's official tutorial,
> Nanoc has filters, which transform content from one format into another.

There are predefined filters. It is also very easy to write one by yourself.

### Enable GitHub Flavored Markdown

Add the RedCarpet gem into `Gemfile`.

```ruby
# Add it to Gemfile
gem 'redcarpet'

# Remeber to run `bundle` after editing the Gemfile
```

[GitHub Flavored Markdown](https://help.github.com/articles/github-flavored-markdown/)

### Add a Rule for Markdown Files

> The Rules file is used to describe the processing rules for items and layouts.

This is the file that needs to be modified in order to tell Nanoc to use the
redcarpet filter, which is provided by Nanoc.

```ruby
# Add this into Rules
compile '/**/*.md' do
  filter :redcarpet
  layout '/default.*'
end
```

> Compilation rules describe how items are processed.

This rule matches items have the `md` extension, and says such items will run
the `redcarpet` filter, followed by laying out the item using the default layout.

### [Write Pages in Markdown (from Nanoc's Official Doc)](http://nanoc.ws/doc/tutorial/#write-pages-in-markdown)

Get rid of the content in `content/index.html` (but leave the frontmatter intact), and replace it with Markdown:

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

Rename the `content/index.html` file to `content/index.md`. `md` is a file extension that is commonly used with Markdown.

Run `nanoc` to re-generate your site and remember to do this when you make
changes to your site.


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
# Add them into Gemfile
gem 'pygments.rb'
gem 'nokogiri'
```

### Custom RedCarpet Filter

Put the snippet below into a file in the `/lib/` directory. Code is explained
with comments in the snippet.

```ruby
# /lib/filters/markdown_with_pygments.rb
require 'redcarpet'
require 'pygments.rb'

# This creates a Renderer which uses Pygments for parsing block code.
class HTMLwithPygments < Redcarpet::Render::HTML
  def block_code(code, language)
    Pygments.highlight(code, lexer: language)
  end
end

# This creates a Markdown parser which uses the Renderer above.
Markdowner = Redcarpet::Markdown.new(HTMLwithPygments, fenced_code_blocks: true)

# This is the custom Nanoc Filter,
# which uses the Markdown parser above for processing content.
class MDFilter < Nanoc::Filter
  identifier :pygmented_md
  type :text
  def run(content, params={})
    Markdowner.render(content)
  end
end
```

Reference: [https://github.com/flyingmachine/nanoc-blog/blob/master/lib/rule_helper.rb](https://github.com/flyingmachine/nanoc-blog/blob/master/lib/rule_helper.rb)

### Add `syntax.css` from Lanyon

* Download [Lanyon](https://github.com/poole/lanyon) from GitHub
* Move `syntax.css` from `lanyon/public/` to `site/content/` #f87e7eb
* Add its path into `/layouts/default.html` #8b75dc2

## Use `guard`

Are you tired of typing `nanoc` again and again when every time you make a
change to the site? Guard is here to help you!

Put the content into their files respectively.

```ruby
# Add these in Gemfile
gem 'guard-nanoc'
gem 'guard-bundler'
gem 'guard-livereload'
```

Explanation about parts of the `Guardfile` is provided by the comments in the snippet below.

```ruby
# Guardfile

# Guard will regenerate the site
# When there's any change applied to
#   * the config of this site
#   * the content of this site
guard 'nanoc' do
  watch('nanoc.yaml')
  watch('Rules')
  watch(%r{^(content|layouts|lib)/.*$})
end

# Guard will install/remove gems
# When there's a change to `Gemfile`
guard :bundler do
  watch('Gemfile')
end

# Guard will reload browser
# When there's change to `output/` directory
guard 'livereload' do
    watch(%r{output/.*$})
end
```

To get live-reload working in the browser, install the [LiveReload Safari/Chrome/Firefox extension](http://livereload.com/extensions#installing-sections).

Commit: #52db121

## Use HAML as Template Language

You can skip this section if you are not interested in using HAML.

Update `Gemfile`:

```ruby
# Add it to Gemfile
gem 'haml'
```

### Code block

Use `~ yield` rather than `= yield` in `layouts/*` otherwise you will get wrong indentation in
code blocks.

### Add/Update Rules

Apply following changes to the `Rules` file to get HAML working.

```diff
# Find the line with `:erb` and change erb to haml
- layout '/**/*', :erb
+ layout '/**/*', :haml
```

Commit: #c13139d

```rb
# Add this into your Rules file
compile '/**/*.haml' do
  filter :haml
  layout '/default.*'
end
```

```diff
# Find the line containing route for `html` and `md`,
# and add haml into the existing route
- route '/**/*.{html,md}' do
+ route '/**/*.{html,md,haml}' do
```

Commit: #d5e8d39

## Adopt Lanyon Theme

### CSS Files

* Remove the stylesheet that comes with nanoc itself
* Copy and paste Lanyon's css files into `content/`, namely
  * `poole.css`
  * `lanyon.css`

Commit: #459ea62

### Rules

```ruby
# Add this to Rules
compile '/**/*.{css}' do
  write "/public/css#{item.identifier}" # identifier contains '/'
end
```

### Layouts

* Use [Convert HTML to HAML](http://htmltohaml.com/) to convert HTML templates
  into HAML
* Turn Liquid template statements into HAML ones

Commits: #cc306de, #89a773b

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
