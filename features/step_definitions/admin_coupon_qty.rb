############ step definitions for Then /^I want to search with the coupon code and check the respective fields of coupon$/ ##################################

When /^I want to search with the coupon code and check the respective fields of coupon$/ do
  $coupon_code = $coupon_code[0].to_s
 # $coupon_code = "20549549"
  BROWSER.text_field(:id, "search_order_security_code_booking_or_security_code_coupon_contains").set $coupon_code
  Then "I \"search_submit\" the search"                                                                              ##admin_order_flter.rb
   And "I want to check the quantity in \"Qty.\" field"                                                              ##admin_order_qty.rb
  Then "I want to check the original value in \"Value\" field"                                                       ##admin_order_qty.rb
  Then "I want to check the discounted value in \"P. Amount\" field"                                                 ##admin_order_qty.rb
end
