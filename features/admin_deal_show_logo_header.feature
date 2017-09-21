Feature:
  As a Admin I want to upload logo and header in the coupon

  Scenario Outline: DEAL ENTRY
    And I go to "http://alpha.akhoni.com/manage" if i don't need to "Sign In" with "admin_user@akhoni.com" and "secret"
    And I go to "alpha.akhoni.com/manage/deals"
    Then I edit a deal and know the merchant name
    Then I check the coupon for logo and header
  Examples:
    | url                     |
    | http://alpha.akhoni.com |










  