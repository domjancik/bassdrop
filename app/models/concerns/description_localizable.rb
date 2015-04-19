module DescriptionLocalizable
  def description
    desc = self.read_attribute description_column(I18n.locale)
    return self.read_attribute 'description' if desc.blank?
    desc
  end

  def description_column(locale)
    return 'description' if locale.eql? :en
    "description_#{locale.to_s}"
  end
end