require 'rails_helper'

RSpec.describe Performance, type: :model do
  # TODO test stage-venue validation
  # TODO test date_start and date_limit range in event date validation

  before(:each) { @performance = Performance.all.take }

  it 'Test performance is created' do
    expect(@performance).to be_truthy
  end

  it 'B2B Association' do
    expect(@performance.b2bs.size).to eq(0)

    first_b2b_performance = FactoryGirl.create(:performance)
    second_b2b_performance = FactoryGirl.create(:performance)

    first_b2b_performance.b2b = @performance
    first_b2b_performance.save

    @performance.reload
    expect(@performance.b2bs.size).to eq(1)
    expect(@performance.b2bs).to include(first_b2b_performance)

    second_b2b_performance.b2b = @performance
    second_b2b_performance.save

    @performance.reload
    expect(@performance.b2bs.size).to eq(2)
    expect(@performance.b2bs).to include(second_b2b_performance)
  end
end
