
########################### Step Definitions And "I have to redeem the coupon with \"\" and \"\""  #######################

And /^I have to redeem the coupon with "([^\"]*)" and "([^\"]*)"$/ do |coupon_code, ver_code|
  When "I go to \"http://alpha.akhoni.com/manage/orders\""                                                         ##my_steps.rb
  BROWSER.text_field(:id, "search_security_code_booking_or_coupons_security_code_coupon_contains").set coupon_code
  Then "I \"search_submit\" the search"                                                                            ##admin_order_flter.rb
  And "I want to know the column number of \"Merchant\" of \"list\" from index number \"1\""                       ##admin_order_flter.rb
  $merchant_col = $column_number
  $merchant = BROWSER.table(:class, "list").row(:index, 2)[$merchant_col].text
  sleep 10
  Then "I go to \"http://alpha.akhoni.com/merchant/report\""                                                       ##my_steps.rb
  if BROWSER.text.include? $merchant
    BROWSER.link(:text, $merchant).click
    BROWSER.text_field(:id, "search_security_code_coupon_contains").set coupon_code
    Then "I \"search_submit\" the search"
    if BROWSER.div(:class, "button_inside_border_blue button_redeem").exist?
      BROWSER.div(:class, "button_inside_border_blue button_redeem").click
      BROWSER.text_field(:id, "code_verification").set ver_code
      BROWSER.button(:text, "Verify").click
    end
  end
end

######################### Step Definitions And I want to search with the coupon code and check the gift and redeemed field in coupon ###############

When /^I want to search with the coupon code and check the gift and redeemed field in coupon$/ do
   $coupon = $coupon_code[0].to_s
#  $coupon = "47037505"
#  $verification_code= "8"
  $verification_code = $coupon_code[1].to_s
   #sleep 10
  BROWSER.text_field(:id, "search_order_security_code_booking_or_security_code_coupon_contains").set $coupon
  Then "I \"search_submit\" the search"                                                                           ##admin_order_flter.rb
  And "I want to know the column number of \"Gift?\" of \"list\" from index number \"1\""                         ##admin_order_flter.rb
  $gift = $column_number
  Then "I check \"Yes\" in \"list\" in \"#{$gift}\""                                                              ##admin_order_flter.rb
  And "I have to redeem the coupon with \"#{$coupon}\" and \"#{$verification_code}\""
  sleep 10
  Then "I go to \"http://alpha.akhoni.com/manage/coupons\""                                                       ##my_steps.rb
  And "I want to know the column number of \"Redeemed?\" of \"list\" from index number \"1\""                     ##admin_order_flter.rb
  $redeemed = $column_number
  Then "I check \"Yes\" in \"list\" in \"#{$redeemed}\""                                                          ##admin_order_flter.rb
end