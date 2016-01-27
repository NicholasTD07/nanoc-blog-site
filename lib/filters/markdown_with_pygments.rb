require 'redcarpet'
require 'pygments.rb'

# https://github.com/flyingmachine/nanoc-blog/blob/master/lib%2Frule_helper.rb
class HTMLwithPygments < Redcarpet::Render::HTML
  def block_code(code, language)
    Pygments.highlight(code, lexer: language)
  end
end

Markdowner = Redcarpet::Markdown.new(HTMLwithPygments,
                                     tables: true,
                                     autolink: true,
                                     underline: true,
                                     strikethrough: true,
                                     fenced_code_blocks: true,
                                    )

class MDFilter < Nanoc::Filter
  identifier :pygmented_md
  type :text
  def run(content, params={})
    Markdowner.render(content)
  end
end
