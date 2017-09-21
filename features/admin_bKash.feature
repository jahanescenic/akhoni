Feature:
  As a Admin I want to Give entry of a mobile transaction and show the coupon to that respective user

  Scenario Outline: BUY
    And I go to "http://alpha.akhoni.com/manage" if i don't need to "Sign In" with "admin_user@akhoni.com" and "secret"
    And I go to "alpha.akhoni.com/manage/mobile_transactions"
    When I go for a "New Mobile transaction"
    Then I enter mobile number, "32" , transaction id to respective fields
    When i go to url "<url>"
    And  I click to place an order by clicking Buy
    And  May be I need to sign in with my "<name>" and "<secret>"
    And  I can change the quantity with value "2" if i'm on the "Your Purchase" page
    Then I am in "Your Purchase" page and I will click buy and go to the page "Your Order Details"
    And  I will fill the following user records

       | name_error                             | phone_error                 | address_error               |
       | Firstname can not be blank.            | Phone can not be blank.     | Address can not be blank.   |


    Then I am in "Your Purchase" page and I will click buy and go to the page "Your Order Details"
    Then I "pay_cash_by_mobile" and press "pay_now" and check my coupon


  Examples:
    | url                     | name               |  secret   |
    | http://alpha.akhoni.com/dhaka/ |  user@akhoni.com | secret |










  