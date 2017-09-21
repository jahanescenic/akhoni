Feature:
  As a user I want check all the menu links

Scenario: menu_links
  When I go to url "http://alpha.akhoni.com"
  When I click to the link "Deals"
  Then The Page Should show Multiple deals or Single deal
  When I click to the link "Products"
  Then The page should show "right-side-bar productsindex curvyIgnore"
#  When I click to the link "Recent deals"
#  Then The Page Should Say "Recent Deals"
  When I click to the link "How it works"
  Then The Page Should Say "How Akhoni.com works?"
  When I click to the link "Feature your business"
  Then The Page Should Say "Feature Your Business"
  When I click to the link "Terms of use"
  Then The Page Should Say "Terms and conditions"
  When I click to the link "About"
  Then The Page Should Say "About akhoni"
  When I click to the link "Contact us"
  Then The Page Should Say "Contact Information"
  When I click to the link "Career"
  Then The Page Should Say "Career Opportunities With Akhoni.com"
  When I click to the link "Get Coupon On Your Mobile"
  Then image "Get-coupon-on-your-mobile-phone-en" should be shown
  When I click to the link "We Accept"
  Then image "Pop_up_writing_for_credit-en" should be shown
  When I click to the link "Privacy Policy"
  Then The Page Should Say "Privacy Policy"



  