# Nanoc Blog Site

A blog site created with Nanoc and other open source tools.

Demo: http://dev.nicktd.com/nanoc-blog-site/

![Screenshot(sidebar hidden)](https://dl.dropboxusercontent.com/u/212792226/screenshots/nanoc-blog-site-v1.0.0-sidebar-hidden.png)
![Screenshot(sidebar shown)](https://dl.dropboxusercontent.com/u/212792226/screenshots/nanoc-blog-site-v1.0.0-sidebar-shown.png)

## Summary of its "Stack"

* [Nanoc](http://nanoc.ws/) as static site generator
* [HAML](http://haml.info/) as template engine
* [Lanyon](http://lanyon.getpoole.com/) as the theme you are seeing right now
* [Guard](https://github.com/guard/guard) for regenerating site and live-reloading browser
* [Rake](https://github.com/ruby/rake) for manging tasks
* [Pygments](http://pygments.org/) for syntax highlighting
* [GitHub Flavored Markdown](https://help.github.com/articles/github-flavored-markdown/) for writing blogs

Read more about how it was built in [this post](http://dev.nicktd.com/nanoc-blog-site/posts/2016-01-25-new-blog-site-with-nanoc/).

## How To Use it?

0. Download this repo (as zip or clone)
0. Install Dependencies: `rake bootstrap`
0. Configure `nanoc.yaml` (only 3 lines)
0. Write with your favorite editor
0. Generate your site
  * With one line: `nanoc`
  * Or, use `guard` to have it to regenerate your site and reload your browser when there's a change

Read the more detailed [How to Use this Blog Site](http://dev.nicktd.com/nanoc-blog-site/posts/2016-01-29-how-to-use-this-blog-site/).


## TODOs

* [ ]  Disqus
* [ ]  Multilingual (see [this doc from Nanoc](http://nanoc.ws/doc/guides/creating-multilingual-sites/))
* [ ]  Pagination

### Assets Pipeline

* [  ] Compile CSS files into one
* [  ] Compile JS files into one
