module Coverable extend ActiveSupport::Concern
  included do
    has_attached_file :cover, path: '/:class/:attachment/:id_partition/cover_:style.:extension', styles: {
                                 thumb: '100x37#',
                                 small: '500x185#',
                                 medium: '734x272#',
                                 large: '1000x370#',
                                 square_medium: '250x250#',
                                 square_big: '500x500#'
                             }

    validates_attachment_content_type :cover, :content_type => /\Aimage\/.*\Z/
  end

  def cover_url(style = :large)
    return cover_missing_url if cover_file_name.nil?
    cover.url style
  end
end