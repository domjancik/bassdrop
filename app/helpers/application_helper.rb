module ApplicationHelper
  def desc_format(data)
    auto_link(simple_format(data)) do |url|
      new_url = url
      new_url.gsub! /https?:\/\//, ''
      new_url.truncate 40
    end
  end
end
