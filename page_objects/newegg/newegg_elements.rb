class NewEggElements < SitePrism::Page
    element :login_btn, :xpath, "//div[contains(text(), 'Sign in / Register')]"

    element :stay_us_btn, :xpath, "//button[contains(text(),'Stay at United States')]"
    element :close_popup_btn, :xpath, "(//a[@id='popup-close'])[1]"
    element :email_field, :xpath, "//input[@id='labeled-input-signEmail']"
    element :password_field, :xpath, "//input[@id='labeled-input-password']"
    element :signin_btn, :xpath, "//button[@id='signInSubmit']"

    #Search item 
    element :tab_search, :xpath, "//input[@type='search']"
    element :search_btn, :xpath, "//button[@class='fas fa-search']"
    element :first_result, :xpath, "(//div[@class='item-cells-wrap border-cells items-grid-view four-cells expulsion-one-cell']/div[@class='item-cell']/div[@class='item-container'])[1]"
    element :add_to_cart_btn, :xpath, "//*[@id='ProductBuy']//button[@class='btn btn-primary btn-wide']"
    #start checkout
    element :checkout_btn, :xpath, "//button[@class='btn btn-primary btn-wide']"
    element :add_address, :xpath, "//i[(@class='card-icon-plus') and contains(@aria-label, 'add new')]"

    #Data fields 
    element :name_field, :xpath, "//input[@name='FirstName']"
    element :last_name_field, :xpath, "//input[@name='LastName']"
    element :address_field, :xpath, "//input[@name='Address1']"
    element :city_field, :xpath, "//input[@name='City']"
    element :zip_code_field, :xpath, "//input[@name='ZipCode']"
    element :phone_field, :xpath, "//input[@name='Phone']"

    element :save_addres_chckbx, :xpath, "//input[contains(@aria-label, 'save address')]"
    element :make_default_chckbx, :xpath, "//input[contains(@aria-label, 'make default')]"
    element :save_address_btn, :xpath, "//button[@class='btn btn-primary']"
    element :popup_extra, :xpath, "//button[@class='close']"
    element :confirm_address, :xpath, "//button[contains(text(),'Use Address as Entered')]"
    element :continue_delivery, :xpath, "//button[contains(text(),'Continue to delivery')]"
end
