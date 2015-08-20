module StringIDable extend ActiveSupport::Concern
  included do
    before_save :default_id_string
  end

  class_methods do
    def find_universal(id)
      return self.find(id) if /^[0-9]*$/.match id
      self.find_by(id_string: id)
    end
  end

  def to_param
    id_string
  end

  def generate_id_string(repeats = 0)
    id = I18n.transliterate(self.title).gsub(/[^0-9A-Za-z]/, '').downcase
    id << (repeats + 1).to_s if repeats != 0

    dup_instance = self.class.find_by(id_string: id);
    return generate_id_string(repeats + 1) if dup_instance && !dup_instance.eql?(self)

    id
  end

  def default_id_string
    self.id_string = generate_id_string if id_string.blank?
  end
end