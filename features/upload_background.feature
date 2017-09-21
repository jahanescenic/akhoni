Feature:
  As an user, I want to upload a background image

  Scenario Outline: BACKGROUND
    When i go to url "<url>"
    Then I click on "Sign In"
    And I sign in with "admin_user@akhoni.com" and "secret"
    Then I go to "http://alpha.akhoni.com/manage/UploadBackgroundImage"
    Then I upload a background image

    Examples:
    | url  |
    | http://alpha.akhoni.com |







  