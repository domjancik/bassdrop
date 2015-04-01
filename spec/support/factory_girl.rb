RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end

RSpec.configure do |config|
  # additional factory_girl configuration

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      FactoryGirl.lint
      example.run
    end
  end
end