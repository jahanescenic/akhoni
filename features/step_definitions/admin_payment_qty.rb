

########################## Step Definitions Then "I want to check the original value in \"\" field of \"\"" #############

Then /^I want to check the original value in "([^\"]*)" field of "([^\"]*)"$/ do |value, index|
  index = index.to_i
  And "I want to know the column number of \"#{value}\" of \"list\" from index number \"1\""
  org_val = $column_number
  org_val= org_val.to_i
  puts index
  puts org_val
  puts BROWSER.table(:class,"list").row(:index,index)[org_val].text
  original_value = BROWSER.table(:class,"list").row(:index,index)[org_val].text
  if $value == original_value.to_i
    puts original_value
  end
end

######################## Step Definitions Then "I want to check the discounted value in \"\" field of \"\"" ##############

Then /^I want to check the discounted value in "([^\"]*)" field of "([^\"]*)"$/ do |value, index|
  index = index.to_i
  And "I want to know the column number of \"#{value}\" of \"list\" from index number \"1\""
  dis_val = $column_number
  discounted_value = BROWSER.table(:class, "list").row(:index, index)[dis_val].text
  if $dis_value == discounted_value.to_i
    puts discounted_value
  end
end

####################### Step Definitions Then "I want to check the refferal balance in \"\" field of \"\"" ###############

Then /^I want to check the refferal balance in "([^\"]*)" field of "([^\"]*)"$/ do |value, index|
  index = index.to_i
  And "I want to know the column number of \"#{value}\" of \"list\" from index number \"1\""
  ref_val = $column_number
  refferal_value = BROWSER.table(:class, "list").row(:index, index)[ref_val].text
  if $referral_balance.to_i == refferal_value.to_i
    puts refferal_value
  end
end

##################### Step Definitions Then "I want to check the payable value in \"\" field of \"\"" ####################

Then /^I want to check the payable value in "([^\"]*)" field of "([^\"]*)"$/ do |value, index|
  index = index.to_i
  And "I want to know the column number of \"#{value}\" of \"list\" from index number \"1\""
  pay_val = $column_number
  payable_value = BROWSER.table(:class, "list").row(:index, index)[pay_val].text
  if $pay_value == payable_value.to_i
    puts payable_value
  end
end

##################### Step Definitions Then "I want to check the charges and discounts in \"\" field of \"\"" ###############

Then /^I want to check the charges and discounts in "([^\"]*)" field of "([^\"]*)"$/ do |value, index|
  index = index.to_i
  And "I want to know the column number of \"#{value}\" of \"list\" from index number \"1\""
  charge_col = $column_number
  charges_discounts = BROWSER.table(:class, "list").row(:index, index)[charge_col].text
  if $charges_discounts == charges_discounts.to_i
    puts charges_discounts
  else
    puts "SOMETHING WENT WRONG ON CHARGES AND DISCOUNTS"
  end
end

############################### Step Definitions And I want to search with the coupon code and check the respective fields of payment #############

When /^I want to search with the coupon code and check the respective fields of payment$/ do
  puts $charges_discounts
  Then "I go to \"alpha.akhoni.com/manage/orders\""
  $coupon = $coupon_code[0].to_s
  BROWSER.text_field(:id, "search_security_code_booking_or_coupons_security_code_coupon_contains").set $coupon

  Then "I \"search_submit\" the search"                                                                          ##my_steps.rb
  And "I want to know the column number of \"Order#\" of \"list\" from index number \"1\""                       ## admin_order_filter.rb
  $order_col = $column_number
  $order_no = BROWSER.table(:class, "list").row(:index, 2)[$order_col].text
  if BROWSER.link(:text, "PAYMENTS").exist?
    BROWSER.link(:text, "PAYMENTS").click
     Then "I \"Reset\" the page"
  end
  if BROWSER.checkbox(:id, "selectDate").exist?
    BROWSER.checkbox(:id, "selectDate").set
    BROWSER.select_list(:id, "search_paid_at_greater_than_or_equal_to_4i").select_value("00")
    date = BROWSER.select_list(:id, "search_paid_at_greater_than_or_equal_to_3i").value
    date = date.to_i
    date =date-1

    if date == 0
      date = 31
      BROWSER.select_list(:id, "search_paid_at_greater_than_or_equal_to_3i").select_value(date)
      month = BROWSER.select_list(:id, "search_paid_at_greater_than_or_equal_to_2i").value
      month = month.to_i
      month = month-1
      if month == 0
        month = 12
        BROWSER.select_list(:id, "search_paid_at_greater_than_or_equal_to_2i").select_value(month)
        year = BROWSER.select_list(:id, "search_paid_at_greater_than_or_equal_to_1i").value
        year = year.to_i
        year = year-1
        BROWSER.select_list(:id, "search_paid_at_greater_than_or_equal_to_1i").select_value(year)
      else
        BROWSER.select_list(:id, "search_paid_at_greater_than_or_equal_to_2i").select_value(month)
      end
    else
      BROWSER.select_list(:id, "search_paid_at_greater_than_or_equal_to_3i").select_value(date)
    end

    Then "I \"search_submit\" the search"
  end
  if BROWSER.table(:class, "list").exist?
    And "I want to know the column number of \"Order ID\" of \"list\" from index number \"1\""                  ## admin_order_filter.rb
    $order_col_pay = $column_number
    BROWSER.table(:class, "list").rows.each_with_index do |row, index|
      if index>=1
        if BROWSER.table(:class, "list").row(:index, index)[$order_col_pay].text == $order_no
          $final_index = index
          $final_index = $final_index.to_i
        end
      end

    end
    Then "I want to check the original value in \"Original Value\" field of \"#{$final_index}\""
    Then "I want to check the discounted value in \"Discounted Value\" field of \"#{$final_index}\""
    Then "I want to check the refferal balance in \"Referral Credit\" field of \"#{$final_index}\""
    Then "I want to check the payable value in \"Paid Amount\" field of \"#{$final_index}\""
    Then "I want to check the charges and discounts in \"Charges and Discounts\" field of \"#{$final_index}\""
  end
   Then "I \"Reset\" the page"
end