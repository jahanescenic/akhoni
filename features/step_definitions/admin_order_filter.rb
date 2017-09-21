$case = 0
$no_of_case = 9

################### Step Definitions Then "I \"\" the search"  ##############################

Then /^I "([^\"]*)" the search$/ do |search|
  BROWSER.button(:id, search).click
  if BROWSER.table(:class, "list").exist?
    row_value = BROWSER.table(:class, "list").row_count()
    puts "Displaying #{row_value-3} users"
  end
end

################### Step Definitions And "I want to know the column number of \"\" of \"\" from index number \"\""  #################################

And /^I want to know the column number of "([^\"]*)" of "([^\"]*)" from index number "([^\"]*)"$/ do |column_name, table_class, ind|
  row_value = BROWSER.table(:class, table_class).row_count()
  column_val = BROWSER.table(:class, table_class).column_count(index = 1)
  #column_val = BROWSER.table(:class, table_class).row(:index, index).column_count()
  $col=0
  $column_number = 0
  while $col<column_val do
    $col = $col.to_i
    ind = ind.to_i
    #puts BROWSER.table(:class, "list")[1][0].text.to_s
    if BROWSER.table(:class, table_class)[ind][$col].text.to_s == column_name.to_s
      $column_number = $col
    end
    $col+=1
  end
end

################### Step Definitions Then "I go to \"\" if exist"  #################################


Then /^I go to "([^\"]*)" if exist$/ do |next_page|
  if BROWSER.link(:class, next_page).exist?
    BROWSER.link(:class, next_page).click
    if BROWSER.table(:class, "list").exist?
      row_value = BROWSER.table(:class, "list").row_count()
      puts "Displaying #{row_value-3} users"
    end
  else
    $page = 1
  end
end

################### Step Definitions Then "I check \"\" in \"\" in \"\""  #################################

Then /^I check "([^\"]*)" in "([^\"]*)" in \"([^\"]*)"$/ do |checking_text, table_class, column_number|
  column_number = column_number.to_i
  row_value = BROWSER.table(:class,"list").row_count()
  BROWSER.table(:class, table_class).rows.each_with_index do |row, index|
    if index > 1 && index < (row_value-1)
        if BROWSER.table(:class, table_class).row(:index, index)[column_number].text.include? checking_text
          puts checking_text
        else
          puts "NOTHING SHOWN"
        end

    end
  end

end

#################################### Step Definitions Then "I calculate the number of rows with \"\",\"\" and check the rows showing right result"  #############################

Then /^I calculate the number of rows with "([^\"]*)","([^\"]*)" and check the rows showing right result$/ do |option, merchant|

  if BROWSER.table(:class, "list").exist?
    And "I want to know the column number of \"Status\" of \"list\" from index number \"1\""
    $status_col= $column_number
    And "I want to know the column number of \"Merchant\" of \"list\" from index number \"1\""
    $merchant_col = $column_number
    $page=0
    while ($page!=1)
      Then "I check \"#{option}\" in \"list\" in \"#{$status_col}\""
      Then "I check \"#{merchant}\" in \"list\" in \"#{$merchant_col}\""
      Then "I go to \"next_page\" if exist"
    end
  else
    puts "NO ORDERS"
  end
end

######################## Step Definitions Then "I check the booking code and customer name"  #######################################

Then /^I check the booking code and customer name$/ do

  if BROWSER.table(:class, "list").exist?

    And "I want to know the column number of \"Booking Code\" of \"list\" from index number \"1\""
    $booking_code_col = $column_number
    And "I want to know the column number of \"Name\" of \"list\" from index number \"1\""
    $name_col = $column_number

    booking_code = BROWSER.table(:class, "list").row(:index, 2)[$booking_code_col].text
    customer_name = BROWSER.table(:class, "list").row(:index, 2)[$name_col].text
    BROWSER.text_field(:id, "search_security_code_booking_or_coupons_security_code_coupon_contains").set booking_code
    BROWSER.text_field(:id, "search_user_firstname_or_user_lastname_or_user_phone_or_user_email_contains").set customer_name
    Then "I \"search_submit\" the search"

    $page=0
    while ($page!=1)
      Then "I check \"#{booking_code}\" in \"list\" in \"#{$booking_code_col}\""
      Then "I check \"#{customer_name}\" in \"list\" in \"#{$name_col}\""
      Then "I go to \"next_page\" if exist"
    end
  else
    puts "NO ORDERS"
  end
end

############################### Step Definitions  Then "I \"\" the page" #####################################################

Then /^I "([^\"]*)" the page$/ do |reset|
  puts "reset"
  BROWSER.button(:value, reset).click

end

################## Step Definitions Then "I enter order entries \"\" and \"\" and \"\" and \"\" and \"\"" ###############################

Then /^I enter order entries "([^\"]*)" and "([^\"]*)" and "([^\"]*)" and "([^\"]*)" and "([^\"]*)"$/ do |deal_product, payment_method, type, option, product|

  if option == "confirmed"
    if BROWSER.checkbox(:id, "search_confirmed_by_greater_than_or_equal_to").exist?
      BROWSER.checkbox(:id, "search_confirmed_by_greater_than_or_equal_to").set
      BROWSER.select_list(:id, "search_confirmed_by_equals").select_value("3")
    elsif BROWSER.checkbox(:id, "search_order_confirmed_by_greater_than_or_equal_to").exist?
      BROWSER.checkbox(:id, "search_confirmed_by_greater_than_or_equal_to").set
      BROWSER.select_list(:id, "search_order_confirmed_by_equals").select_value("3")
    end

  elsif option=="Paid" && payment_method != "NEXUS"

    if BROWSER.checkbox(:id, "search_is_notified_is_true").exist?
      BROWSER.checkbox(:id, "search_is_notified_is_true").set
      BROWSER.select_list(:id, "search_payments_collector_id_equals").select_value("3")
    elsif BROWSER.checkbox(:id, "search_order_is_notified_is_true").exist?
      BROWSER.checkbox(:id, "search_order_is_notified_is_true").set
      BROWSER.select_list(:id, "search_order_payments_collector_id_equals").select_value("3")
    elsif BROWSER.checkbox(:id, "search_orders_is_notified_is_true").exist?
      BROWSER.checkbox(:id, "search_orders_is_notified_is_true").set
    end

  elsif option == "Cancelled"
    BROWSER.checkbox(:id, "search_canceled_by_greater_than_or_equal_to").set
  elsif option == "Redeemed"
    BROWSER.checkbox(:id, "search_redeemed_by_user_id_greater_than_or_equal_to").set
  elsif option == "INITIALIZE" or option == "VALID" or option == "INVALID"
    BROWSER.select_list(:id, "search_status_equals").select_value(option)
  elsif option == "Not redeemed"

    BROWSER.checkbox(:id, "search_orders_coupons_redeemed_by_user_id_is_null").set
  end
  if product != ""
    if BROWSER.select_list(:id, "search_product_id_equals").exist?
      BROWSER.select_list(:id, "search_product_id_equals").select_value(product)
    elsif BROWSER.select_list(:id, "search_order_product_id_equals").exist?
      BROWSER.select_list(:id, "search_order_product_id_equals").select_value(product)
    elsif BROWSER.select_list(:id, "search_orders_product_id_equals").exist?
      BROWSER.select_list(:id, "search_orders_product_id_equals").select_value(product)
    end
  end
  if deal_product != ""
    if  BROWSER.select_list(:id, "search_deal_id_or_deal_parent_id_equals").exist?
      BROWSER.select_list(:id, "search_deal_id_or_deal_parent_id_equals").select_value(deal_product)
    elsif BROWSER.select_list(:id, "search_order_deal_id_or_order_deal_parent_id_equals").exist?
      BROWSER.select_list(:id, "search_order_deal_id_or_order_deal_parent_id_equals").select_value(deal_product)
    elsif BROWSER.select_list(:id, "search_orders_deal_id_or_orders_deal_parent_id_equals").exist?
      BROWSER.select_list(:id, "search_orders_deal_id_or_orders_deal_parent_id_equals").select_value(deal_product)
    end
  end
  if payment_method != ""
    if BROWSER.select_list(:id, "search_payments_method_equals").exist?
      BROWSER.select_list(:id, "search_payments_method_equals").select_value(payment_method)
    elsif BROWSER.select_list(:id, "search_method_equals").exist?
      BROWSER.select_list(:id, "search_method_equals").select_value(payment_method)
    end
  end
  if type != ""
    BROWSER.select_list(:id, "search_deal_type_id_equals").select_value(type)
  end
end

####################################### Step Definitions Given The Following order records #################################################

Given /^The Following order records$/ do |table|
  # table is a |   Set menu at The 8_single deal - buffet    |   CASH    |   Paid    |  paid   |
  table.hashes.each do |hash|
    $case = $case+1
    deal_product = hash["deal/product"]
    payment_method = hash["payment_method"]
    type = hash["type"]
    option = hash["option"]
    merchant = hash["merchant"]
    product = hash["product"]
    puts $case
    puts merchant + deal_product

    Then "I enter order entries \"#{deal_product}\" and \"#{payment_method}\" and \"#{type}\" and \"#{option}\" and \"#{product}\""

    Then "I \"search_submit\" the search"
    if not BROWSER.text.include? "Filter User"
      puts "orders"
      Then "I calculate the number of rows with \"#{option}\",\"#{merchant}\" and check the rows showing right result"
      puts "no_of case #{$no_of_case}"
      if $case == $no_of_case
        puts "entered"
        Then "I check the booking code and customer name"
      end

    end

    Then "I \"Reset\" the page"
  end
end