Feature:
  As an admin, I want to upload press release information on the website

  Scenario Outline: PRESS_RELEASE
    When i go to url "<url>"
    And  I go to "http://alpha.akhoni.com/manage/presses" if i don't need to "Sign In" with "admin_user@akhoni.com" and "secret"
    When I go for a "New Press Release"
    Then I enter following data
     | title_press                    | description   | url                      |
     |                          | random_special|                          |
     | random_special           |               |                          |
     | random                   | random        | valid                    |

    #Then I want to confirm an order and expact "confirmed successfully"



  Examples:
    | url                     |
    | http://alpha.akhoni.com/manage/presses |










  