Feature:
  As a user I want to Buy a Product

  Scenario Outline: BUY PRODUCT
    When i go to url "<url>"
    Then I go to a product's details
    Then I set "checkout_use_referral"
     Then I set "checkout_use_referral" and press "pay_now"

  Examples:
    | url  |
    | http://alpha.akhoni.com/dhaka/products |







  