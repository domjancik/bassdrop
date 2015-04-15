module RedcarpetHelper
  def redcarpet_render(content)
    @@markdown ||= Redcarpet::Markdown.new(HTMLBlockCode, :fenced_code_blocks => true)
    @@markdown.render(content)
  end
end

class HTMLBlockCode < Redcarpet::Render::HTML
  include Sprockets::Rails::Helper
  include ActionView::Helpers::UrlHelper
  include ActionView::Context

  def parse_media_link(link)
    puts link
    matches = link.match(/^([\w\d\.]+)(?:\|(\w+))?(?:\|([\w\s\d]+))?$/)
    {
        :id => matches[1],
        :size => (matches[2] || 'original').to_sym,
        :class => matches[3]

    } if matches
  end

  def image(link, title, alt_text)
    size = nil
    klass = nil
    parse = parse_media_link(link)

    unless parse.nil?
      image = Image.find_by(id: parse[:id]) || Image.find_by(title: parse[:id])
      if image
        style = parse[:size]
        size = image.image.image_size(style)
        link = image.image.url(style)
        klass = parse[:class]

        img_tag = image_tag(link, :size => size, :title => title, :alt => alt_text, :class => klass)

        if style.eql? :original
          return img_tag
        else
          return link_to Rails.application.routes.url_helpers.reveal_image_path(image), data: {'reveal-id' => 'reveal', 'reveal-ajax' => 'true'} do
            img_tag
          end
        end
      end
    end
    ''
  end
end