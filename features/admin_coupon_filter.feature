Feature:
  As a collector, I want to filter an order with specific information

  Scenario Outline: COUPON_FILTER
    When i go to url "<url>"
    And  I go to "http://alpha.akhoni.com/manage" if i don't need to "Sign In" with "admin_user@akhoni.com" and "secret"
    And  I go to "http://alpha.akhoni.com/manage/coupons"
    Given The Following order records
    |   deal/product                              | product  | merchant          |  payment_method    |   type    |   option            |
    |   3                                         |          | The 8 Restaurant  |                    |           |  Paid               |
    |   3                                         |          | The 8 Restaurant  |                    |           |  Redeemed           |
    |   3                                         |          | The 8 Restaurant  |                    |           |  Paid               |
    |   15                                        | 8        | Atrium Restaurant |                    |           |  Paid               |
    |   15                                        | 8        | Atrium Restaurant |                    |           |  Redeemed           |
    |   15                                        | 8        | Atrium Restaurant |                    |           |  Paid               |
    |                                             | 18       | Ecstasy           |                    |           |  Paid               |
    |                                             | 18       | Ecstasy           |                    |           |  Redeemed           |
    |                                             | 18       | Ecstasy           |                    |           |  Paid               |
  Examples:
    | url                     |
    | http://alpha.akhoni.com/|










  