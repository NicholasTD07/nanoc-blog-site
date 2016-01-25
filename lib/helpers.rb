# Any files in /lib/ will be included by Nanoc

# See here for full list of methods included in helpers
# http://nanoc.ws/doc/reference/helpers/

include Nanoc::Helpers::Blogging
# articles() → Array
#   Returns an unsorted list of articles, i.e.
# sorted_articles() → Array
#   Returns a sorted list of articles, i.e.
# atom_feed(params) → String
#   Returns a string representing the atom feed containing recent articles, sorted by descending creation date.
# url_for(item) → String
#   Returns the URL for the given item.
# feed_url() → String
#   Returns the URL of the feed.
# atom_tag_for(item) → String
#   Returns an URI containing an unique ID for the given item.
# attribute_to_time(time) → Time
#   Converts the given attribute (which can be a string, a Time or a Date) into a Time.

include Nanoc::Helpers::LinkTo
# link_to(text, target, attributes) → String
#   Creates a HTML link to the given path or item representation, and with the given text.
# link_to_unless_current(text, target, attributes) → String
#   Creates a HTML link using {#link_to}, except when the linked item is the current one.
# relative_path_to(target) → String
#   Returns the relative path from the current item to the given path or item representation.

include Nanoc::Helpers::Rendering
# render(identifier, other_assigns, &block) → String
#   Renders the given layout.

include Nanoc::Helpers::Tagging
# tags_for(item, params) → String
# items_with_tag(tag) → Array
# link_for_tag(tag, base_url) → String

