Before do |scenario|
  if ENV['WEB_DRIVER'].to_s.upcase != "NONE"
    Capybara.page.current_window.maximize
  end
end
