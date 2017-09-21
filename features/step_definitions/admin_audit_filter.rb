##################### Step Definitions Then "i give entry of \"\" in \"\" audit filter fields" #####################

Then /^i give entry of "([^\"]*)" in "([^\"]*)" audit filter fields$/ do |option,field|
  if BROWSER.select_list(:id,field).exist?
    BROWSER.select_list(:id,field).select_value(option)
  end
end

##################### Step Definitions Then "I want to go the page \"\" again" #############################

Then /^I want to go the page "([^\"]*)" again$/ do |page_no|
   if BROWSER.div(:class,"pagination").link(:text,page_no).exist?
     BROWSER.div(:class,"pagination").link(:text,page_no).click
   end
end

########################## Step Definitions Then "I check the table for \"\" in \"\"" ################

Then /^I check the table for "([^\"]*)" in "([^\"]*)"$/ do |option,column|
  And "I want to know the column number of \"#{column}\" of \"list\" from index number \"1\""   ##admin_order_filter.rb
  option_col = $column_number
  $page=0
    while ($page!=1)
      Then "I check \"#{option}\" in \"list\" in \"#{option_col}\""                            ##admin_order_filter.rb
      Then "I go to \"next_page\" if exist"                                                    ##admin_order_filter.rb
    end
end

###################### Step Definitions Given The Following audit records ###########################

Given /^The Following audit records$/ do |table|
  # table is a | |
  table.hashes.each do |hash|
   auditable_type = hash["Auditable_Type"]
    operation = hash["Operation"]
    date_start = hash["Date_start"]
    date_end = hash["Date_end"]
    Then "i give entry of \"#{auditable_type}\" in \"search_auditable_type_equals\" audit filter fields"
    Then "i give entry of \"#{operation}\" in \"search_action_equals\" audit filter fields"
    Then "I \"search_submit\" the search"                                                      ##admin_order_filter.rb
   if BROWSER.table(:class,"list").exist?
    Then "I check the table for \"#{auditable_type}\" in \"Item\""
    Then "I want to go the page \"1\" again"
    Then "I check the table for \"#{operation}\" in \"Operation\""
     end
  end
end