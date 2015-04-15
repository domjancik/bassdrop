module Imageable extend ActiveSupport::Concern
  included do
    has_attached_file :image, path: '/:class/:attachment/:id_partition/:style/:filename', styles: {
                                 thumb: '120x120#',
                                 square_small: '200x200#',
                                 square_medium: '250x250#',
                                 square_big: '500x500#',
                                 small: '200x200>',
                                 medium: '250x250>',
                                 big: '500x500>',
                             }

    validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  end
end