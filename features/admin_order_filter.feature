Feature:
  As a collector, I want to filter an order with specific information

  Scenario Outline: ORDER_FILTER
    When i go to url "<url>"
    And  I go to "http://alpha.akhoni.com/manage" if i don't need to "Sign In" with "admin_user@akhoni.com" and "secret"
    And  I click on "ORDER" and select "List"
    Given The Following order records
    |   deal/product   | product  | merchant          |  payment_method    |   type    |   option            |
    |   3              |          | The 8 Restaurant  |  CASH              |   1       |  Paid               |
    |   3              |          | The 8 Restaurant  |  CASH              |   1       |  Cancelled          |
    |   3              |          | The 8 Restaurant  |  NEXUS             |   1       |  Paid               |
    |   15             | 8        | Atrium Restaurant |  CASH              |   2       |  Paid               |
    |   15             | 8        | Atrium Restaurant |  CASH              |   2       |  Cancelled          |
    |   15             | 8        | Atrium Restaurant |  NEXUS             |   2       |  Paid               |
    |                  | 18       | Ecstasy           |  CASH              |           |  Paid               |
    |                  | 18       | Ecstasy           |  CASH              |           |  Cancelled          |
    |                  | 18       | Ecstasy           |  NEXUS             |           |  Paid               |
  Examples:
    | url                     |
    | http://alpha.akhoni.com/manage|










  