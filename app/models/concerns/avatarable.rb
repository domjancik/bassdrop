module Avatarable extend ActiveSupport::Concern
  included do
    has_attached_file :avatar, path: '/:class/:attachment/:id_partition/avatar_:style.:extension', styles: {
                                 thumb: '120x120#',
                                 small: '200x200#',
                                 medium: '250x250#',
                                 big: '500x500#',
                                 large: '500x500>'
                             }

    validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  end

  def image_url(style = :original)
    return image_missing_url if avatar_file_name.nil?
    avatar.url style
  end
end