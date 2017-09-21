Feature:
  As a admin I want to "confirm" and "mark as paid" an order

  Scenario Outline: ORDER_LIST
    When i go to url "<url>"
    And  I go to "http://alpha.akhoni.com/manage" if i don't need to "Sign In" with "admin_user@akhoni.com" and "secret"
    And  I click on "ORDER" and select "List"
    And I choose a order from the "list" and check whether it is paid or not
    #Then I want to confirm an order and expact "confirmed successfully"



  Examples:
    | url                     |
    | http://alpha.akhoni.com/manage |










  