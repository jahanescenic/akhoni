Feature:
  As an user, I want to update my information

  Scenario Outline: CHANGE INFO
    When i go to url "<url>"
    Then I click on "Sign In"
    And I sign in with "new_user@akhoni.com" and "secret"
    Then I go to "alpha.akhoni.com/settings/"
    Given The following user update records
      |   phone               |   password  |   password_confirmation   | messeges                                               |
     #|   blank               |   secret    |   secret                  | Phone is the wrong length (should be 11 characters)    |
      |   random_valid        |   secret    |   secre                   | Password doesn't match confirmation                    |
     #|   random_invalid      |   secret    |   secret                  | Phone is invalid                                       |
      |   random_valid        |             |   secret                  | Password can't be blank                                |
      |   random_valid        |   secret    |                           | Password doesn't match confirmation                    |
     #|   random_wrong_length |   secret    |   secret                  | Phone is the wrong length (should be 11 characters)    |
    Examples:
    | url  |
    | http://alpha.akhoni.com |







  