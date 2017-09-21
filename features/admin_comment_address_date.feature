Feature:
  As a admin I want to give comment's and address with special chars with date

  Scenario Outline: ORDER_LIST
    When i go to url "<url>"
    And  I go to "http://alpha.akhoni.com/manage" if i don't need to "Sign In" with "admin_user@akhoni.com" and "secret"
    And  I click on "ORDER" and select "List"
    And  I click on the "Info" link




  Examples:
    | url                     |
    |http://alpha.akhoni.com/manage |










  