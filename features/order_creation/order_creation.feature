Feature: Test Scenario
  Scenario Outline: Create and online order
    Given User open the <store> store with "Chrome" browser
    When User loging with <user> and <password> in online store
    Then User add <item> to the cart
    Then User proceed to checkout

    Examples: Store, credentials
      | store | user | password  | item |
      | 'newegg' | @gmail.com' | '' | 'laptop_acer' |
