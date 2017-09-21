Feature:
  As a Admin I want to Give entry of a deal details

  Scenario Outline: DEAL ENTRY
    And I go to "http://alpha.akhoni.com/manage" if i don't need to "Sign In" with "admin_user@akhoni.com" and "secret"
    And I go to "alpha.akhoni.com/manage/deals/new"
    Then I give entry of a new deal
  Examples:
    | url                     | name               |  secret   |
    | http://alpha.akhoni.com/dhaka/set-menu-at-the-8_single-deal/buy/new |  user@akhoni.com | secret |










  