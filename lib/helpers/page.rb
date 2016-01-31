# https://github.com/nanoc/nanoc/blob/master/lib/nanoc/helpers/blogging.rb
module Items
  def posts_of_year(year)
    sorted_articles.select { |a| a[:created_at].year == year }
  end

  def pages
    blk = -> { @items.select { |item| item[:kind] == 'page' } }
    if @items.frozen?
      @page_items ||= blk.call
    else
      blk.call
    end
  end
end

include Items
