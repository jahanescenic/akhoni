Feature:
  As a collector, I want to edit an user

  Scenario Outline: USER_INFO_EDIT
    When i go to url "<url>"
    Then I click on "Sign Up"
    Then I will sign up with random user generation
    And  I go to "http://alpha.akhoni.com/manage" if i don't need to "Sign In" with "admin_user@akhoni.com" and "secret"
    And  I go to "http://alpha.akhoni.com/manage/users/verify"
    Then I search the user and edit the user

  Examples:
    | url                     |
    | http://alpha.akhoni.com/|










  