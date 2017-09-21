
########################### Step Definitions Then "I give the entry of \"\" and \"\" and \"\" and \"\" and check the result" ###############

Then /^I give the entry of "([^\"]*)" and "([^\"]*)" and "([^\"]*)" and "([^\"]*)" and check the result$/ do |id,customer_name,address,gender|
  BROWSER.text_field(:id,"search_id_greater_than_or_equal_to").set id
  BROWSER.text_field(:id,"search_id_less_than_or_equal_to").set id
  BROWSER.text_field(:id,"search_email_or_firstname_or_lastname_or_phone_contains").set customer_name
  BROWSER.text_field(:id,"search_address_contains").set address
  BROWSER.select_list(:id,"search_gender_equals").select_value(gender)
  BROWSER.button(:id,"search_submit").click
  Then "I check \"#{customer_name}\" in \"list\" in \"#{$name_col}\""                                                    ## admin_order_filter.rb
  Then "I check \"#{address}\" in \"list\" in \"#{$address_col}\""                                                       ## admin_order_filter.rb
  Then "I check \"#{id}\" in \"list\" in \"#{$id_col}\""                                                                 ## admin_order_filter.rb
  Then "I check \"#{gender}\" in \"list\" in \"#{$gender_col}\""                                                         ## admin_order_filter.rb
end

################## Step Definitions And "I give the entry of \"\" in \"\" and check the result in \"\""  #########################

And /^I give the entry of "([^\"]*)" in "([^\"]*)" and check the result in "([^\"]*)"$/ do |text,field,column_number|
  BROWSER.text_field(:id,field).set text
  BROWSER.button(:id,"search_submit").click
  Then "I check \"#{text}\" in \"list\" in \"#{column_number}\""
end

########## Step Definitions And "I give the entry of \"\" in \"\" and \"\" and check the result" ###############

And /^I give the entry of "([^\"]*)" in "([^\"]*)" and "([^\"]*)" and check the result$/ do |sign_in_count,field1,field2|
  BROWSER.text_field(:id,field1).set sign_in_count
  BROWSER.text_field(:id,field2).set sign_in_count
  BROWSER.button(:id,"search_submit").click
  row_value = BROWSER.table(:class, "list").row_count()
  puts "Displaying #{row_value-3} users"
end

######################## Step Definitions Then I store an user record to test the search filter ##################

Then /^I store an user record to test the search filter$/ do
  if BROWSER.table(:class, "list").exist?
    And "I want to know the column number of \"ID\" of \"list\" from index number \"1\""                                 ## admin_order_filter.rb
    $id_col = $column_number
    And "I want to know the column number of \"Name\" of \"list\" from index number \"1\""                               ## admin_order_filter.rb
    $name_col = $column_number
    And "I want to know the column number of \"Email\" of \"list\" from index number \"1\""                              ## admin_order_filter.rb
    $email_col = $column_number
    And "I want to know the column number of \"Phone\" of \"list\" from index number \"1\""                              ## admin_order_filter.rb
    $phone_col = $column_number
    And "I want to know the column number of \"Address\" of \"list\" from index number \"1\""                            ## admin_order_filter.rb
    $address_col = $column_number
    And "I want to know the column number of \"Gender\" of \"list\" from index number \"1\""                             ## admin_order_filter.rb
    $gender_col = $column_number

    customer_name = BROWSER.table(:class, "list").row(:index, 2)[$name_col].text
    email = BROWSER.table(:class, "list").row(:index, 2)[$email_col].text
    phone = BROWSER.table(:class, "list").row(:index, 2)[$phone_col].text
    address = BROWSER.table(:class, "list").row(:index, 2)[$address_col].text
    gender = BROWSER.table(:class, "list").row(:index, 2)[$gender_col].text
    if gender == "Female"
      gender = "F"
    else
      gender = "M"
    end
    id = BROWSER.table(:class, "list").row(:index, 2)[$id_col].text
    Then "I give the entry of \"#{id}\" and \"#{customer_name}\" and \"#{address}\" and \"#{gender}\" and check the result"
    And "I give the entry of \"#{email}\" in \"search_email_or_firstname_or_lastname_or_phone_contains\" and check the result in \"#{$email_col}\""
    if BROWSER.link(:text,"Show").exist?
      BROWSER.link(:text,"Show").click
      @sign_in_count = BROWSER.div(:class,"content").table(:index,3).row(:index,1).text
      if BROWSER.td(:text, "Sign In Count").exist?
      @sign_in_count = BROWSER.td(:text, "Sign In Count").parent.cell(:index, 2).text
      puts @sign_in_count
      end
      if BROWSER.link(:text,"Back to List").exist?
        BROWSER.link(:text,"Back to List").click
      end
    end
    Then "I \"Reset\" the page"                                                                                           ## admin_order_filter.rb
    And "I give the entry of \"#{@sign_in_count}\" in \"search_sign_in_count_greater_than_or_equal_to\" and \"search_sign_in_count_less_than_or_equal_to\" and check the result"
    Then "I \"Reset\" the page"                                                                                           ## admin_order_filter.rb

  end
end