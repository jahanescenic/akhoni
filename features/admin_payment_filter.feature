Feature:
  As a collector, I want to filter payment with specific information

  Scenario Outline: PAYMENT_FILTER
    When i go to url "<url>"
    And  I go to "http://alpha.akhoni.com/manage" if i don't need to "Sign In" with "admin_user@akhoni.com" and "secret"
    And  I go to "http://alpha.akhoni.com/manage/payments"
    Given The Following order records
    |   deal/product                              | product | merchant          |  payment_method    |   type    |   option                  |
    |   3                                         |          | The 8 Restaurant  |  CASH             |           |  INITIALIZE               |
    |   3                                         |          | The 8 Restaurant  |  CASH             |           |  VALID                    |
    |   3                                         |          | The 8 Restaurant  |  CASH             |           |  INVALID                  |
    |   3                                         |          | The 8 Restaurant  |  NEXUS            |           |  INITIALIZE               |
    |   3                                         |          | The 8 Restaurant  |  NEXUS            |           |  VALID                    |
    |   3                                         |          | The 8 Restaurant  |  NEXUS            |           |  INVALID                  |
    |   15                                        | 8    | Atrium Restaurant |  CASH             |           |  INITIALIZE               |
    |   15                                        | 8    | Atrium Restaurant |  CASH             |           |  VALID                    |
    |   15                                        | 8    | Atrium Restaurant |  CASH             |           |  INVALID                  |
    |   15                                        | 8    | Atrium Restaurant |  NEXUS            |           |  INITIALIZE               |
    |   15                                        | 8    | Atrium Restaurant |  NEXUS            |           |  VALID                    |
    |   15                                        | 8    | Atrium Restaurant |  NEXUS            |           |  INVALID                  |
    |                                             | 18   | Ecstasy           |  CASH             |           |  INITIALIZE               |
    |                                             | 18   | Ecstasy           |  CASH             |           |  VALID                    |
    |                                             | 18   | Ecstasy           |  CASH             |           |  INVALID                  |
    |                                             | 18   | Ecstasy           |  NEXUS            |           |  INITIALIZE               |
    |                                             | 18   | Ecstasy           |  NEXUS            |           |  VALID                    |
    |                                             | 18   | Ecstasy           |  NEXUS            |           |  INVALID                  |
  Examples:
    | url                     |
    | http://alpha.akhoni.com/|










  