class AddIdStringToModels < ActiveRecord::Migration
  # model symbol, order clause
  MODELS = [
      [ :artists, '' ],
      [ :events, 'events.date_start asc' ],
      [ :releases, ''],
      [ :stories, 'published_at asc' ]
  ]

  def generate_id(modelClass, instance, repeats = 0)
    id = I18n.transliterate(instance.title).gsub(/[^0-9A-Za-z]/, '').downcase
    id << (repeats + 1).to_s if repeats != 0
    return generate_id(modelClass, instance, repeats + 1) if modelClass.find_by(id_string: id)

    instance.id_string = id
    instance.save
  end

  def add_id_string(model)
    model_sym = model[0]
    order_clause = model[1]

    add_column model_sym, :id_string, :string
    add_index model_sym, :id_string, unique: true

    modelClass = model_sym.to_s.singularize.camelize.constantize
    modelClass.all.order(order_clause).each do |instance|
      generate_id modelClass, instance
    end

    change_column model_sym, :id_string, :string, null: false
  end

  def remove_id_string(model_sym)
    remove_index model_sym, :id_string
    remove_column model_sym, :id_string
  end

  def up
    MODELS.each { |model| add_id_string model }
  end

  def down
    MODELS.each { |model| remove_id_string model[0] }
  end
end
