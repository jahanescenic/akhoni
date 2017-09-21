Feature:
  As a admin I want to approve a product and show it on product list

  Scenario Outline: PRODUCT_APPROVE
    When i go to url "<url>"
    And  I go to "http://alpha.akhoni.com/manage" if i don't need to "Sign In" with "admin_user@akhoni.com" and "secret"
    And  I go to "http://alpha.akhoni.com/manage/products"
    And I approve a product and check it on product list when it is "featured"




  Examples:
    | url                     |
    | http://alpha.akhoni.com |










  