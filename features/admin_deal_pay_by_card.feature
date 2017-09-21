Feature:
  As a Admin I want to deactivate/activate "pay by card" of a deal details

  Scenario Outline: DEAL ENTRY
    And I go to "http://alpha.akhoni.com/manage" if i don't need to "Sign In" with "admin_user@akhoni.com" and "secret"
    And I go to "alpha.akhoni.com/manage/deals"
   Then I edit a deal and "deactivate" pay by card option
   Then I click on "HOME" link
    Then I check pay by card option in frontend
  Examples:
  ###### to run the test case of pay by card activation just change the text "deactivate" to "activate" ###########
    | url                     |
    | http://alpha.akhoni.com |










  