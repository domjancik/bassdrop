module GenericModelable extend ActiveSupport::Concern
  def model
    instance_variable_get("@#{model_var_name}")
  end

  def model_var_name
    controller_name.classify.downcase
  end
end