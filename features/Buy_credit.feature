Feature:
  As a user I want to Buy with credit card

  Scenario Outline: BUY
    When i go to url "<url>"
    And  I click to place an order by clicking Buy
    And  May be I need to sign in with my "<name>" and "<secret>"
    And  I can change the quantity with value "1" if i'm on the "Your Purchase" page
    Then I am in "Your Purchase" page and I will click buy and go to the page "Your Order Details"
    And  I will fill the following user records

    | name_error                             | phone_error                 | address_error               |
    | Firstname can't be blank            | Phone can not be blank     | Address can't be blank   |


    Then I am in "Your Purchase" page and I will click buy and go to the page "Your Order Details"
    Then I set "checkout_use_referral"
    Then I check "Credit Card Charge"
    Then I check "Corporate Discount"
    Then I "pay_cash_by_credit_debit_card" and press "pay_now"
    And  if i'm in "sslcommerzlogo" site then press for "nexus" transaction and click on "Proceed to Pay" button and expect "Success Transaction"
    Then i click on "Success Transaction" and search for the text "Coupon Code"
  Examples:
    | url                                                      | name                | secret   |
    | http://alpha.akhoni.com | user@akhoni.com     | secret   |










  