module ApplicationHelper
  def header_and_page_title(title)
    content_for(:page_title, title)
    content_tag(:h1, title)
  end
end
