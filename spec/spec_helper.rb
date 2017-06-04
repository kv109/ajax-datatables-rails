require 'simplecov'

# Start Simplecov
SimpleCov.start do
  add_filter 'spec/'
end

# Load dummy app
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../dummy/config/environment.rb', __FILE__)
require 'rspec/rails'
require 'rspec-html-matchers'
require 'capybara/rails'
require 'capybara/rspec'
require 'capybara-screenshot/rspec'
require 'capybara/poltergeist'
require 'database_cleaner'
require 'factory_girl'
require 'faker'
require 'pry'

# Load support files
Dir[File.expand_path('../support/**/*.rb', __FILE__)].each { |f| require f }

# Make ActiveRecord create the database for us
ActiveRecord::Migration.maintain_test_schema!

# Configure RSpec
RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.include Capybara::DSL
  config.include Rails.application.routes.url_helpers
  config.include RSpecHtmlMatchers

  config.before(:suite) do
    FactoryGirl.find_definitions
  end

  config.after(:each) do
    AjaxDatatablesRails.configure do |c|
      c.db_adapter = ActiveRecord::Base.connection.adapter_name.downcase.to_sym
      c.orm = :active_record
    end
  end

  config.color = true
  config.fail_fast = false

  config.use_transactional_fixtures = true

  config.order = :random
  Kernel.srand config.seed

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end

# Specs flagged with `js: true` will use Capybara's JS driver. Set
# that JS driver to :poltergeist
Capybara.javascript_driver = :poltergeist
