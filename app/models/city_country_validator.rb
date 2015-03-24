class CityCountryValidator < ActiveModel::Validator
  def validate(record)
    unless record.city.blank? || record.country == record.city.country
      record.errors[:base] << "The city doesn't match the specified country"
    end
  end
end