Feature:
  As a user I want to sign in

  Scenario Outline: Login
    When i go to url "<url>"
    Then I click on "Sign In"
    Given The following user records
      | username                    | password   | messeges                      | roles               |
      | ,                           | secret     | Invalid email or password.    |                     |
      | ,                           | secre      | Invalid email or password.    |                     |
      | @,.                         |            | Invalid email or password.    |                     |
      |                             |            | Invalid email or password.    |                     |
      |                             | secret     | Invalid email or password.    |                     |
      | @,.                         | secre      | Invalid email or password.    |                     |
      | admin_user@akhoni.com       | secret     | Welcome, admin_user@akhoni.com| Admin               |
      | collector@akhoni.com        | secret     | Welcome, collector@akhoni.com | Admin               |
      | copywriter@akhoni.com       | secret     | Welcome, copywriter@akhoni.com| Admin               |
      | marchant@akhoni.com         | secret     | Welcome, marchant@akhoni.com  | Report              |
      | new_user@akhoni.com         | secret     | Welcome, user@akhoni.com      |                     |

  Examples:
    | url  |
    | http://alpha.akhoni.com |







  