class PerformanceStageValidator < ActiveModel::Validator
  def validate(record)
    unless record.stage.blank? || record.stage.venue == record.event.venue
      record.errors[:stage] << "The stage doesn't match the performance's venue"
    end
  end
end