Feature:
  As a collector, I want to filter an user with specific information

  Scenario Outline: USER_FILTER
    When i go to url "<url>"
    And  I go to "http://alpha.akhoni.com/manage" if i don't need to "Sign In" with "admin_user@akhoni.com" and "secret"
    And  I go to "http://alpha.akhoni.com/manage/users"
    Then I store an user record to test the search filter
    Given The Following order records
    |   deal/product | product  | merchant          |  payment_method    |   type    |   option            |
    |   3            |          | The 8 Restaurant  |                   |           |  Paid               |
    |   3            |          | The 8 Restaurant  |                   |           |  Not redeemed          |
    |   15           | 8        | Atrium Restaurant |                   |           |  Paid               |
    |   15           | 8        | Atrium Restaurant |                   |           |  Not redeemed          |
    |                | 18       | Ecstasy           |                   |           |  Paid               |
    |                | 18       | Ecstasy           |                   |           |  Not redeemed          |
  Examples:
    | url                     |
    | http://alpha.akhoni.com/|










  