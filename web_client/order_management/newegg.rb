class NewEgg

  def initialize()
  end

  def do_login(user,password)
    begin
      
      query = "Newegg authentication required"
      #$logs.log(query)
      gmail_util = Gmail.new()

      page = NewEggElements.new
    
      Capybara.ignore_hidden_elements = false

      #Popups for country
      country_validation = Capybara.page.has_xpath?("//button[@class='btn btn-primary']")
      popup_exists = Capybara.page.find(:xpath, "//div[@id='popup']")
      if country_validation
        page.stay_us_btn.click
      end
      if popup_exists
        page.close_popup_btn.click
      end

      #Log in button
      page.login_btn.click

      #Set user and password
      page.email_field.set user 
      sleep(1)
      page.signin_btn.click
      $logs.log("1")
      #check if access code is required 
      i = 0
      code_xpath = "//input[(@type='number') and contains(@aria-label, 'verify code #{i+1}')]"
      code_required = Capybara.page.has_xpath?(code_xpath)
      if code_required
        #Get Access Code 
        access_code = gmail_util.get_access_code_newegg(query).split('')
        #puts access_code
        while i <= 5 
          Capybara.page.find(:xpath, "//input[(@type='number') and contains(@aria-label, 'verify code #{i+1}')]").set access_code[i]
          i = i+1
        end
        page.signin_btn.click
      else 
        page.password_field.set password
        page.signin_btn.click
      end
    rescue => exception
      
    end
  end

  def add_to_cart(item)
    page = NewEggElements.new

    items = YAML.load_file("config/data/items/items.yaml")
    data = YAML.load_file("config/data/address/fake_data.yaml")
    item = items[item]['name']

    $logs.log("---------------------------------------------", :white)
    $logs.log("ADDING ITEM #{item}")
    $logs.log("---------------------------------------------", :white)

    #Search product 
    sleep(3)
    page.tab_search.set item
    sleep(3)
    #$logs.log("#{items[item]['name']}")
    page.search_btn.click
    sleep(10)
    #check if product exists 
    product_exists = Capybara.page.has_xpath?("(//div[@class='item-cells-wrap border-cells items-grid-view four-cells expulsion-one-cell']/div[@class='item-cell'])[1]")
    if product_exists
      sleep(2)
      $logs.log("Product found", :blue)
      page.first_result.click
      sleep(5)
      page.add_to_cart_btn.click
      sleep(2)
    else
      raise "Product not found "
    end

    #Capybara.page.find(:xpath, "//label[@class='form-select is-wide']//option[@value='#{}']")
  end

  def start_checkout()
    $logs.log("---------------------------------------------", :white)
    $logs.log("STARTING CHECKOUT...")
    $logs.log("---------------------------------------------", :white)

    page = NewEggElements.new
    data = YAML.load_file("config/data/address/fake_data.yaml")
    addres_info = data['address_1']

    #start checkout 
    Capybara.visit("https://secure.newegg.com/shop/cart")
    sleep(4)

    #check if popup appaers 
    popup = Capybara.page.has_xpath?("//button[@class='close']")
    if popup
      puts "Popup find"
      page.popup_extra.click
      sleep(3)
    else
      
    end
    page.checkout_btn.click
    sleep(2)
    page.add_address.click
    sleep(3)
    $logs.log("Setting Address Info...")
    page.name_field.set addres_info['name']
    sleep(2)
    page.last_name_field.set addres_info['last_name']
    sleep(2)
    page.address_field.set addres_info['address']
    sleep(2)
    page.city_field.set addres_info['city']
    sleep(2)
    page.zip_code_field.set addres_info['zip_code']
    sleep(2)
    page.phone_field.set addres_info['phone']
    sleep(2)
    Capybara.page.find(:xpath, "//label[@class='form-select is-wide']//option[@value='#{addres_info['city_ab']}']").click
    #sleep(2)
    #page.save_addres_chckbx.click
    sleep(1)
    page.save_address_btn.click
    sleep(3)
    page.confirm_address.click
    sleep(2)
    page.continue_delivery.click

  end

end#end class
