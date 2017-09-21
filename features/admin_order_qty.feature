Feature:
  As a collector, I want to filter an order with specific information and check some respective fields

  Scenario Outline: ORDER_FIELD_CHECK(Qty,Org.Value,Dis.Value,Payable Value)
    When i go to url "<url>"
    And  I click to place an order by clicking Buy
    And  May be I need to sign in with my "<name>" and "<secret>"
    And  I can change the quantity with value "1" if i'm on the "Your Purchase" page
    Then I store the qty of the order
    Then I am in "Your Purchase" page and I will click buy and go to the page "Your Order Details"
    And  I will fill the following user records

    | name_error                             | phone_error                 | address_error               |
    | Firstname can't be blank            | Phone can not be blank     | Address can't be blank   |


    Then I am in "Your Purchase" page and I will click buy and go to the page "Your Order Details"

    Then I "pay_cash_by_credit_debit_card" and press "pay_now"
    Then I store the payable value
    And  if i'm in "sslcommerzlogo" site then press for "nexus" transaction and click on "Proceed to Pay" button and expect "Success Transaction"
    Then i click on "Success Transaction" and store the code
    And I store the original value of the deal
    And I store the discounted value of the deal
    When i go to url "<url>"
    And  I go to "http://alpha.akhoni.com/manage" if i don't need to "Sign In" with "admin_user@akhoni.com" and "secret"
    And  I click on "ORDER" and select "List"
    And I want to search with the coupon code and check the qty field



  Examples:
    | url                     |
    | http://alpha.akhoni.com/dhaka/set-menu-at-the-8_single-deal-3|










  