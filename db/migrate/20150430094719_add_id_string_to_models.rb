class AddIdStringToModels < ActiveRecord::Migration
  MODELS = [
      :artists,
      :events,
      :release,
      :story
  ]

  def add_id_string(model_sym)
    add_column model_sym, :id_string, :string
    add_index model_sym, :id_string, unique: true

    :model_sym.to_s.singularize.camelize.constantize.each do |instance|
      instance.id_string = I18n.transliterate instance.title.downcase.camelize.downcase
    end

    change_column model_sym, :id_string, :string, null: false
  end

  def remove_id_string(model_sym)
    remove_index model_sym, :id_string
    remove_column model_sym, :id_string
  end

  def up
    MODELS.each { |model_sym| add_id_string model_sym }
  end

  def down
    MODELS.each { |model_sym| remove_id_string model_sym }
  end
end
