Feature:
  As a user I want to sign up

  Scenario Outline: SIGN UP
    When i go to url "<url>"
    Then I click on "Sign Up"
    Given the following user records
      | username | password | password_confirmation | phone | errors                                          |
      |          | secret   | secret                | 017,8 | Email can't be blank                            |
      | @@,.     | secret   | secret                | 018,8 | Email is invalid                                |
      | @,..     | secret   | secret                | 019,8 | Email is invalid                                |
      | @,.      |          | secret                | 016,8 | Password can't be blank                         |
      | @,.      | secrett  | secret                | 015,8 | Password doesn't match confirmation             |
      | @,.      | sec      | secret                | 011,8 | Password is too short (minimum is 6 characters) |
     # | @,.      | secret   | secret                | 012,8 | Phone is invalid                                |
      #| @,.      | secret   | secret                | 012,7 | Phone Phone is the wrong length (should be 11 characters)|
      | @,.      | secret   | secret                | 017,8 | Welcome                                         |

  Examples:
    | url  |
    | http://alpha.akhoni.com/users/sign_up |







  