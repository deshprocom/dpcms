module ApplicationHelper

  # 定制标题的公共方法
  def full_title(page_title = '')
    base_title = 'DeshPro CMS'
    if page_title.empty?
      base_title
    else
      page_title + ' · ' + base_title
    end
  end
end
