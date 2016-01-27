# https://github.com/clarkdave/nanoc-blog-example/blob/master/lib%2Fdefault.rb

module PostHelper
  def pretty_date_for_post(post)
    attribute_to_time(post[:created_at]).strftime('%B %-d, %Y')
  end

  def summary_of_post(post)
    content = post.compiled_content
    if content =~ /\s<!-- more -->\s/
      content = content.partition('<!-- more -->').first +
      "<div class='read-more'><a href='#{post.path}'>Continue reading &rsaquo;</a></div>"
    end
    return content
  end
end

include PostHelper
