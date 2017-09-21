Feature:
  As a merchant, I want to give entry of my business details and see the details in admin panel as an admin

  Scenario Outline: FEATURE YOUR BUSINESS
    When i go to url "<url>"
    Then I go to "alpha.akhoni.com/getfeatured"
    Then I give the following request records
      | name_of_com                 | type_of_business     | location             | website       | contact_person         | contact_number     | email_address |
      |                             | random_valid         | random_valid         | .             |  random_valid          | random_valid       | @,.         |
      | random_special_chars        | random_valid         | random_valid         | .             |  random_valid          | random_valid       | @,.         |
      | random_valid                |                      | random_valid         | .             |  random_valid          | random_valid       | @,.         |
      | random_valid                | random_special_chrs  | random_valid         | .             |  random_valid          | random_valid       | @,.         |
      | random_valid                | random_invalid       | random_valid         | .             |  random_valid          | random_valid       | @,.         |
      | random_valid                | random_valid         |                      | .             |  random_valid          | random_valid       | @,.         |
      | random_valid                | random_valid         | random_special_chars | .             |  random_valid          | random_valid       | @,.         |
      | random_valid                | random_valid         | random_valid         |               |  random_valid          | random_valid       | @,.         |
      | random_valid                | random_valid         | random_valid         | .             |                        | random_valid       | @,.         |
      | random_valid                | random_valid         | random_valid         | .             |  random_invalid        | random_valid       | @,.         |
      | random_valid                | random_valid         | random_valid         | .             |  random_special_chars  | random_valid       | @,.         |
      | random_valid                | random_valid         | random_valid         | .             |  random_valid          | random_invalid     | @,.         |
      | random_valid                | random_valid         | random_valid         | .             |  random_valid          |                    | @,.         |
      | random_valid                | random_valid         | random_valid         | .             |  random_valid          | random_wrong_length| @,.         |
      | random_valid                | random_valid         | random_valid         | .             |  random_valid          | random_valid       |             |
      | random_valid                | random_valid         | random_valid         | .             |  random_valid          | random_valid       | @           |
      | random_valid                | random_valid         | random_valid         | .             |  random_valid          | random_valid       | .           |
      | random_valid                | random_valid         | random_valid         | .             |  random_valid          | random_valid       | @,.         |

  Examples:
    | url                     | name               |  secret   |
    | http://alpha.akhoni.com/ |  user@akhoni.com | secret |










  