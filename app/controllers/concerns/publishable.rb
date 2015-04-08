module Publishable extend ActiveSupport::Concern
  include GenericModelable

  # POST /model/1/publish
  def publish
    set_published true
  end

  # POST /model/1/hide
  def hide
    set_published false
  end

  private
    def set_published(value)
      model.published = value
      model.published_at = Time.now if model.has_attribute? :published_at
      model.save
      url = request.referer.blank? ? send("#{model_var_name.pluralize}_url") : request.referer
      redirect_to url
    end
end