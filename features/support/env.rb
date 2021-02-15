require "capybara"
require "capybara/cucumber"
#require "capybara/rails"
require "json"
require "rspec"
require "rspec/expectations"
require 'rspec/collection_matchers'
require "selenium-webdriver"
require "site_prism"
require 'colorize'
require 'open-uri'
require 'auto_data'

Capybara.run_server = false
Capybara.app_host = 'http://my.app'


Dir[File.dirname(File.expand_path("../../", __FILE__)) + "/web_client/**/*.rb"].each { |file| require file }
Dir[File.dirname(File.expand_path("../../", __FILE__)) + "/page_objects/**/*.rb"].each { |file| require file }
Dir[File.dirname(File.expand_path(".", __FILE__)) + "/utils/*.rb"].each { |file| require file }
Dir[File.dirname(File.expand_path(".", __FILE__)) + "/config/*.rb"].each { |file| require file }
Dir[File.dirname(File.expand_path("../../", __FILE__)) + "/config/**/*.rb"].each { |file| require file }

Selenium::WebDriver::Chrome.driver_path = "C:/chromeDriver/chromedriver.exe"

Capybara.register_driver :headless_chrome do |app|
  browser_options = ::Selenium::WebDriver::Chrome::Options.new.tap do |opts|
    opts.args << "--window-size=1920,1080"
    opts.args << "--ignore-certificate-errors"
    opts.args << "--headless"
    opts.args << "--disable-gpu"
    opts.args << "--disable-web-security"
    opts.args << "--no-sandbox"
  end
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: browser_options)
end

Capybara.register_driver :chrome do |app|
  browser_options = ::Selenium::WebDriver::Chrome::Options.new.tap do |opts|
    opts.args << "--ignore-certificate-errors"
    opts.args << "--disable-gpu"
    opts.args << "--disable-web-security"
    opts.args << "--no-sandbox"
    # opts.args << '--disable-logging'
  end
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: browser_options)
end

Capybara.default_driver = :chrome
Capybara.javascript_driver = :chrome

case ENV['WEB_BROWSER'].to_s.downcase
when "chrome"
  Capybara.default_driver = :chrome
  Capybara.javascript_driver = :chrome
when "headless"
  Capybara.default_driver = :headless_chrome
  Capybara.javascript_driver = :headless_chrome
end


Capybara.default_max_wait_time = 10

#For log propouses 
$logs = LogPrint.new