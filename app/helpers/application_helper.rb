module ApplicationHelper

  def text_with_links(text)
    simple_format(text).gsub(URI.regexp, '<a href="\0" target="_blank">\0</a>').html_safe
  end
end
