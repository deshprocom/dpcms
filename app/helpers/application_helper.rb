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

  def markdown(content)
    renderer = Redcarpet::Render::HTML.new(hard_wrap: true, filter_html: true)
    options = {
      autolink: true,
      no_intra_emphasis: true,
      disable_indented_code_blocks: true,
      fenced_code_blocks: true,
      lax_html_blocks: true,
      strikethrough: true,
      superscript: true
    }
    Redcarpet::Markdown.new(renderer, options).render(content).html_safe # rubocop:disable Rails/OutputSafety
  end

  def multilingual_editor_switch
    content = radio_button_tag(:info_lang, 'cn', true) <<
              content_tag(:span, ' 中文 &nbsp&nbsp&nbsp'.html_safe) << # rubocop:disable Rails/OutputSafety
              radio_button_tag(:info_lang, 'en') <<
              content_tag(:span, ' 英文')
    content_tag(:li, content, class: 'common_radio_lang')
  end
end
