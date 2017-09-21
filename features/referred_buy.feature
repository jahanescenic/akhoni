Feature:
  As a user I want to buy a deal by using referral link

Scenario Outline: REFERRED BUY
   When i go to url "<url>"

    #And I need to "Sign Up"
#   Given the following user records
#      | username | password | password_confirmation | phone | errors           |
#      | @,.      | secret   | secret                | 017,8 | Welcome                                         |
    #And  I click to place an order by clicking Buy

    And  I can change the quantity with value "1" if i'm on the "Your Purchase" page
    Then I am in "Your Purchase" page and I will click buy and go to the page "Your Order Details"
    And  I will fill the following user records

    | name_error                             | phone_error                 | address_error               |
    | Firstname can not be blank.            | Phone can not be blank.     | Address can not be blank.   |


    Then I am in "Your Purchase" page and I will click buy and go to the page "Your Order Details"
    Then I set "checkout_use_referral"
    Then I "pay_cash_by_credit_debit_card" and press "pay_now"
    And  if i'm in "sslcommerzlogo" site then press for "nexus" transaction and click on "Proceed to Pay" button and expect "Success Transaction"
    Then i click on "Success Transaction" and search for the text "Coupon Code"
  Examples:
    | url                                                      | name                | secret   |
    | http://alpha.akhoni.com/dhaka/26ggxw8t9yr9bvndqg8-71/buy/new | user@akhoni.com     | secret   |


