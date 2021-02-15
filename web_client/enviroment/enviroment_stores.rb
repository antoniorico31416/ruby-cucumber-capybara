class OnlineStores
  attr_reader :online_store
  attr_reader :browser

  def initialize(store, browser)
    @online_store = store
    @browser = browser
  end

  def set_store()
    case @online_store.downcase
    when 'amazon'
      ENV['STORE'] = "Amazon"
      ENV['URL_STORE'] = "https://www.amazon.com/"
    when 'ebay'
      ENV['STORE'] = "Ebay"
      ENV['URL_STORE'] = "https://www.ebay.com/"
    when 'newegg'
      ENV['STORE'] = "newegg"
      ENV['URL_STORE'] = "https://www.newegg.com/#"
    else
      raise "'#{@online_store}' country is not supported yet"
    end
  end

  def set_browser()
    case @browser.downcase
    when 'chrome'
      ENV['WEB_BROWSER'] = "CHROME"
    when 'headless'
      ENV['WEB_BROWSER'] = "HEADLESS"
    else
      raise "'#{@browser}' browser is not supported yet"
    end
  end

end
