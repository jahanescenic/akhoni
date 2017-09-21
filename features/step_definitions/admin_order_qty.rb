$quantity = 0
$value = 0
$dis_value = 0
$pay_value = 0

########################## Step Definitions Then i click on "" and store the code ###############

Then /^i click on "([^\"]*)" and store the code$/ do |arg1|
  BROWSER.button(:value, arg1).click
  if BROWSER.div(:id, "coupon_code").exist?
    @coupon_code = BROWSER.div(:id, "coupon_code").text
    puts @coupon_code
  end
  coupon_code = @coupon_code.split(" ")
  $coupon_code = coupon_code[2].split("-")
  puts $coupon_code[0]
  sleep 10
end

########################## Step Definitions Then I store the qty of the order ######################################

Then /^I store the qty of the order$/ do
  if BROWSER.text_field(:id, "order_quantity").exist?
    $quantity = BROWSER.text_field(:id, "order_quantity").value
  end
end

######################## Step Definitions Then I store the payable value ###########################################

Then /^I store the payable value$/ do
  @pay_value = BROWSER.td(:text, "akhoni@ssl").parent.cell(:index, 1).text
  pay_value = @pay_value.split(" ")
  $pay_value = pay_value[1].to_i
end

######################## Step Definitions And I store the original value of the deal ################################

When /^I store the original value of the deal$/ do
  @value = BROWSER.td(:text, "Value").parent.cell(:index, 1).text
  value = @value.split(" ")
  $value = value[1].to_i
end

####################### Step Definitions And I store the discounted value of the deal ###############################

When /^I store the discounted value of the deal$/ do
  @dis_value = BROWSER.td(:text, "Paid Amount").parent.cell(:index, 1).text
  dis_value = @dis_value.split(" ")
  $dis_value = dis_value[1].to_i
end

###################### Step Definition And "I want to check the quantity in \"\" field" ########################

And /^I want to check the quantity in "([^\"]*)" field$/ do |arg1|
  And "I want to know the column number of \"#{arg1}\" of \"list\" from index number \"1\""
  $qty = $column_number
  $quantity = $quantity.to_s
  Then "I check \"#{$quantity}\" in \"list\" in \"#{$qty}\""
end

################### Step Definitions Then "I want to check the original value in \"\" field" #############

Then /^I want to check the original value in "([^\"]*)" field$/ do |arg1|
  And "I want to know the column number of \"#{arg1}\" of \"list\" from index number \"1\""
  $val = $column_number
  Then "I check \"#{$value}\" in \"list\" in \"#{$val}\""
end

################## Step Definitions Then "I want to check the discounted value in \"\" field" ############

Then /^I want to check the discounted value in "([^\"]*)" field$/ do |arg1|
  And "I want to know the column number of \"#{arg1}\" of \"list\" from index number \"1\""
  $dis_val = $column_number
  Then "I check \"#{$dis_value}\" in \"list\" in \"#{$dis_val}\""
end

################# Step Definitions  Then "I want to check the payable value in \"\" field" ############

Then /^I want to check the payable value in "([^\"]*)" field$/ do |arg1|
 And "I want to know the column number of \"#{arg1}\" of \"list\" from index number \"1\""
  $pay_val = $column_number
  Then "I check \"#{$pay_value}\" in \"list\" in \"#{$pay_val}\""
end

################### Step Definitions And I want to search with the coupon code and check the qty field #############

When /^I want to search with the coupon code and check the qty field$/ do
  $coupon = $coupon_code[0].to_s
  BROWSER.text_field(:id, "search_security_code_booking_or_coupons_security_code_coupon_contains").set $coupon_code[0]
  Then "I \"search_submit\" the search"                                                                                 ## admin_order_filter.rb
  And "I want to check the quantity in \"Qty.\" field"
  Then "I want to check the original value in \"Org. Value\" field"
  Then "I want to check the discounted value in \"Dis. Value\" field"
  Then "I want to check the payable value in \"Payable Value\" field"
end
