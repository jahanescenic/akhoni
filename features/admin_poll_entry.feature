Feature:
  As an admin, I want to upload a poll on the website

  Scenario Outline: POLL_RELEASE
    When i go to url "<url>"
    And  I go to "http://alpha.akhoni.com/manage/presses" if i don't need to "Sign in" with "admin_user@akhoni.com" and "secret"
    When I go for a "New Poll"
    Then I enter following poll data
     | question              | description       | active                    | options                                                      |
     | poll_question         | poll_description  |  checked                  |  poll_poll_options_attributes_index_to_replace_with_js_option|
     | poll_question         | poll_description  |                  |  poll_poll_options_attributes_index_to_replace_with_js_option|


    #Then I want to confirm an order and expact "confirmed successfully"



  Examples:
    | url                     |
    | http://alpha.akhoni.com/manage/polls |










  