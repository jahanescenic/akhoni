Feature:
  As a Admin I want to Give entry of a corporate discount

  Scenario Outline: CORPORATE_DISCOUNT
    And I go to "http://alpha.akhoni.com/dhaka" if i don't need to "Sign In" with "admin_user@akhoni.com" and "secret"
    And I go to "http://alpha.akhoni.com/manage/corporate_discounts"
    When I go for a "New corporate discount"
    And I enter the following records
       | domain                           | discount                 | type              |  deal                           |    product  | error                  |
       |                                  |                          |                   |                                 |             | Domain can't be blank                       |
       | grameenphone.com                 | 4                        | deal              |                                 |             |                        |
       | banglalink.com                   | 5                        |                   |                                 |             |                        |
       |                                  | 5                        | deal              |  3                              |             | Domain can't be blank  |
       | grameenphone.com                 |                          | product           |                         |          18     | Discount can't be blank|
       |                                  |                          | product           |                         |          18     |                        |
       | banglalion.com                   | 5                        | product           |                         |          18     |                        |
       | banglalion.com                   | 5                        | product           |                         |          18     | Domain has already been taken |
  Then i check the meta search option



  Examples:
    | url                     | name               |  secret   |
    | http://alpha.akhoni.com/dhaka/set-menu-at-the-8_single-deal/buy/new |  user@akhoni.com | secret |










  