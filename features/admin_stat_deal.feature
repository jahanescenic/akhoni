Feature:
  As a admin I want to see statistical report of deals

  Scenario Outline: Report
    When i go to url "<url>"
    And  I go to "http://alpha.akhoni.com/manage" if i don't need to "Sign In" with "analyst@akhoni.com" and "secret"
    And  I click on deal specific report
    And  I enter a date and time and press generate
  Examples:
    | url                     |
    | http://alpha.akhoni.com/manage |










  