Feature:
  As a super admin, I want to suspend an user and want to check whether he/she can login

  Scenario Outline: USER_SUSPEND
    When i go to url "<url>"
    Then I click on "Sign Up"
    Then I will sign up with random user generation
    And  I go to "http://alpha.akhoni.com/manage" if i don't need to "Sign In" with "admin_user@akhoni.com" and "secret"
    And  I go to "http://alpha.akhoni.com/manage/users"
    Then I search for an user and suspend the user
    When i go to url "<url>"
    Then I click on "Sign In"
    When i log in with "user@akhoni.com" and "secret"
    And i submit with "Sign In"
    Then I should see the homepage without signed in
  Examples:
    | url                     |
    | http://alpha.akhoni.com/|










  