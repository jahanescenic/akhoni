Feature:
  As a user I want to Buy with credit card

  Scenario Outline: BUY
    When i go to url "dbadmin.akhoni.com"
    Then I want to enter "akhoni" and "akhoni" as user and password
    When i go to url "<url>"
    And  I click to place an order by clicking Buy
    And  May be I need to sign in with my "<name>" and "<secret>"
    And  I can change the quantity with value "2" if i'm on the "Your Purchase" page
    Then I am in "Your Purchase" page and I will click buy and go to the page "Your Order Details"
    And  I will fill the following user records

      | name_error                             | phone_error                 | address_error               |
      | Firstname can not be blank.            | Phone can not be blank.     | Address can not be blank.   |


    Then I am in "Your Purchase" page and I will click buy and go to the page "Your Order Details"
    Then I set "checkout_use_referral" and press "pay_now"



  Examples:
    | url                     | name               |  secret   |
    | http://alpha.akhoni.com/ |  new_user@akhoni.com | secret |










  