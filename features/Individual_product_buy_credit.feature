Feature:
  As a user I want to Buy a Product

  Scenario Outline: BUY PRODUCT
    When i go to url "<url>"
    Then I go to a product's details
    Then I set "checkout_use_referral"
    Then I "pay_cash_by_credit_debit_card" and press "pay_now"
    And  if i'm in "sslcommerzlogo" site then press for "nexus" transaction and click on "Proceed to Pay" button and expect "Success Transaction"
    Then i click on "Success Transaction" and search for the text "Coupon Code"

  Examples:
    | url  |
    | http://alpha.akhoni.com/dhaka/products |







  