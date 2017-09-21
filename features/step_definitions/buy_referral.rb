
#################### Step Definitions Then I want to enter "" and "" as user and password ################

Then /^I want to enter "([^\"]*)" and "([^\"]*)" as user and password$/ do |arg1, arg2|
  BROWSER.text_field(:name, "pma_username").set arg1
  BROWSER.text_field(:name, "pma_password").set arg2
  if BROWSER.button(:id, "input_go").exist?
    BROWSER.button(:id, "input_go").click
  end
  BROWSER.goto "http://dbadmin.akhoni.com/tbl_change.php?db=akhoni_development&table=users&where_clause=%60users%60.%60id%60+%3D+1203&clause_is_unique=1&sql_query=SELECT+%2A+FROM+%60users%60+ORDER+BY+%60users%60.%60id%60++DESC&goto=sql.php&token=d6c20ea706c1014678277fddab0fa633"
  BROWSER.text_field(:name, "fields[multi_edit][0][e3181552d30aa406303e36fdb8701442]").set "10"
  if BROWSER.button(:type, "submit").exist?
    BROWSER.button(:type, "submit").click
  end
end

###################### Step Definitions Then I set "" and press "" #####################

Then /^I set "([^\"]*)" and press "([^\"]*)"$/ do |arg1, arg2|
  if  BROWSER.checkbox(:id, arg1).exist?
    BROWSER.checkbox(:id, arg1).set
  end
  BROWSER.button(:id, arg2).click if BROWSER.button(:id, arg2).exist?
end