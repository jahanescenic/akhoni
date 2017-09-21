Feature:
  As a Admin I want to filter product by product and merchant name

  Scenario Outline: Product
    And I go to "http://alpha.akhoni.com/manage" if i don't need to "Sign In" with "admin_user@akhoni.com" and "secret"
    And I go to "alpha.akhoni.com/manage/products"
    And I select merchant name from the list of options
    And I press "Reset" button and check the functionality



  Examples:
    | url                     | name               |  secret   |
    | http://alpha.akhoni.com/dhaka/set-menu-at-the-8_single-deal/buy/new |  user@akhoni.com | secret |










  