module ApplicationHelper
  def page_title(title = '')
    base_title = '椅子寝'
    title.present? ? "#{title} | #{base_title}" : base_title
  end
end
