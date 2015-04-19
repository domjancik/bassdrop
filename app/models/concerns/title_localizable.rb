module TitleLocalizable
  def title
    desc = self.read_attribute title_column(I18n.locale)
    return self.read_attribute 'title' if desc.blank?
    desc
  end

  def title_column(locale)
    return 'title' if locale.eql? :en
    "title_#{locale.to_s}"
  end
end