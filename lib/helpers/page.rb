# https://github.com/nanoc/nanoc/blob/master/lib/nanoc/helpers/blogging.rb
module Page
  def pages
    blk = -> { @items.select { |item| item[:kind] == 'page' } }
    if @items.frozen?
      @page_items ||= blk.call
    else
      blk.call
    end
  end
end

include Page
