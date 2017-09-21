Feature:
  As a user i want to check my authorized features

  Scenario Outline: AUTHORIZATION
    When i go to url "<url>"

    Then I give The following user records

    | username                    | password   |
    #| deal_admin@akhoni.com       | secret     |
#   | user@akhoni.com             | secret     |
#    | admin_user@akhoni.com       | secret     |
#    | collector@akhoni.com        | secret     |
#    | copywriter@akhoni.com       | secret     |
#    | merchant@akhoni.com         | secret     |
#    | crm@akhoni.com              | secret     |
    |analyst@akhoni.com           | secret     |


    #And  I go to "http://alpha.akhoni.com/manage" if i don't need to "Sign in" with "admin_user@akhoni.com" and "secret"

    #And I choose a order from the "list" and check whether it is paid or not




  Examples:
    | url                     |
    | http://alpha.akhoni.com |










  