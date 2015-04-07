module ApplicationHelper
  def desc_format(data, enable_markdown = true)
    if enable_markdown
      markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
      data = raw markdown.render(data)
    else
      data = simple_format data
    end

    auto_link(data) do |url|
      new_url = url
      new_url.gsub! /https?:\/\//, ''
      new_url.truncate 40
    end
  end
end
