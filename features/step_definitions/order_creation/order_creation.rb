Given("User open the {string} store with {string} browser") do |store, browser|
  $logs.log("---------------------------------------------", :white)
  $logs.log("Setting store #{store.capitalize} with #{browser} browser")
  $logs.log("---------------------------------------------", :white)
  @enviroment_store = OnlineStores.new(store,browser)
  @enviroment_store.set_store()
  @enviroment_store.set_browser()
  Capybara.visit(ENV['URL_STORE'])
  sleep(10)
end

When("User loging with {string} and {string} in online store") do |user, password|
  $logs.log("---------------------------------------------", :white)
  $logs.log("LOG IN WITH #{user}")
  $logs.log("---------------------------------------------", :white)
  @newegg = NewEgg.new()
  @newegg.do_login(user, password)
  #$logs.log("Result")
end

Then("User add {string} to the cart") do |item|
  @newegg = NewEgg.new()
  @newegg.add_to_cart(item)
end

Then("User proceed to checkout") do 
  @newegg = NewEgg.new()
  @newegg.start_checkout()
end
