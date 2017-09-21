Feature:
  As a admin I want to see statistical report of deals

  Scenario Outline: Report
    When i go to url "<url>"
    And  I go to "http://alpha.akhoni.com/manage" if i don't need to "Sign In" with "collector@akhoni.com" and "secret"
    And  I click on "ORDER" and select "List"
    Then  I want to enter a comment on "3"

    #Then I want to confirm an order and expact "confirmed successfully"



  Examples:
    | url                     |
    | http://alpha.akhoni.com |










  