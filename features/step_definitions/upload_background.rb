######################### Step Definitions Then "I press \"\" button" ##############

Then /^I press "([^\"]*)" button$/ do |arg1|
  BROWSER.button(:name, arg1).click
end

######################## Step Definitions  Then "The page should show success" #################

Then /^The page should show success$/ do
 if BROWSER.contains_text "Background Successfully Uploaded"
   puts "Successully Uploaded"
 else
   puts "error occured"
 end
end

######################### Step Definitions Then I upload a background image ####################

Then /^I upload a background image$/ do
  #BROWSER.button(:id,"background_image").click
  BROWSER.file_field(:id, "background_image").set("E:\\pics\\African_Sunset.jpg")
  Then "I press \"commit\" button"

  Then "The page should show success"
end
