Feature:
  As a collector, I want to filter an audit with specific information

  Scenario Outline: AUDIT_FILTER
    When i go to url "<url>"
    And  I go to "http://alpha.akhoni.com/manage" if i don't need to "Sign In" with "admin_user@akhoni.com" and "secret"
    And  I go to "http://alpha.akhoni.com/manage/audits"
    Given The Following audit records
    |    Auditable_Type                           | Operation  | Date_start          |  Date_end      |
    |   Product                                   |   create   |                     |                |
    |   Product                                   |   update   |                     |                |
    |   Product                                   |   destroy  |                     |                |
    |   Deal                                      |   create   |                     |                |
    |   Deal                                      |   update   |                     |                |
    |   Deal                                      |   destroy  |                     |                |
    |   Order                                     |   create   |                     |                |
    |   Order                                     |   update   |                     |                |
    |   Order                                     |   destroy  |                     |                |
    |   Payment                                   |   create   |                     |                |
    |   Payment                                   |   update   |                     |                |
    |   Payment                                   |   destroy  |                     |                |
    |   Coupon                                    |   create   |                     |                |
    |   Coupon                                    |   update   |                     |                |
    |   Coupon                                    |   destroy  |                     |                |
    |   Notification                              |   create   |                     |                |
    |   Notification                              |   update   |                     |                |
    |   Notification                              |   destroy  |                     |                |
    |   Merchant                                  |   create   |                     |                |
    |   Merchant                                  |   update   |                     |                |
    |   Merchant                                  |   destroy  |                     |                |
    |   PaymentSummary                            |   create   |                     |                |
    |   PaymentSummary                            |   update   |                     |                |
    |   PaymentSummary                            |   destroy  |                     |                |
    |   User                                      |   create   |                     |                |
    |   User                                      |   update   |                     |                |
    |   User                                      |   destroy  |                     |                |
    |   PaymentReceive                            |   create   |                     |                |
    |   PaymentReceive                            |   update   |                     |                |
    |   PaymentReceive                            |   destroy  |                     |                |
    |   Notice                                    |   create   |                     |                |
    |   Notice                                    |   update   |                     |                |
    |   Notice                                    |   destroy  |                     |                |
    |   CorporateDiscount                         |   create   |                     |                |
    |   CorporateDiscount                         |   update   |                     |                |
    |   CorporateDiscount                         |   destroy  |                     |                |
  Examples:
    | url                     |
    | http://alpha.akhoni.com/manage|










  