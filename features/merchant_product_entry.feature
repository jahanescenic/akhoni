Feature:
  As a merchant, I want to enter a product with specific information

  Scenario Outline: MERCHANT_PRODUCT_ENTRY
    When i go to url "<url>"
    And  I go to "http://alpha.akhoni.com/merchant/report" if i don't need to "Sign In" with "merchant@akhoni.com" and "secret"
    And  I go to "http://alpha.akhoni.com/merchant/products"
    And I click on "New Product" link
    Then I give product entry
    Then I go to "http://alpha.akhoni.com/dhaka/products"
    Then I will look for a pending product and shouldn't find it on product page as it is not approved
  Examples:
    | url                     |
    | http://alpha.akhoni.com |










  