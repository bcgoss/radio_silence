RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :rack_test
  end

  config.before(:each, type: :system, js: true) do
    ActiveRecord::Base.establish_connection
    driven_by :selenium_chrome_headless
  end
end
