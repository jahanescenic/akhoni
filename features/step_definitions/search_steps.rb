##################### Step Definitions  When I go to url "" #####################

When(/^I go to url "([^"]+)"$/) { |url| BROWSER.goto url }

###################### Step Definitions Then The Page Should Say "Recent Deals" ########################

When /^The Page Should Say "([^"]+)"$/ do |text|
  puts BROWSER.text.include? text
end

############################# Step Definitions Then The Page Should show Multiple deals or Single deal ##################

Then /^The Page Should show Multiple deals or Single deal$/ do
  if BROWSER.div(:class,"right-side-bar dealsindex curvyIgnore") or BROWSER.div(:class,"right-side-bar dealsshow")
    puts "OKK"
  end
end

############################ Step Definitions  Then image "" should be shown #############

Then /^image "([^\"]*)" should be shown$/ do |arg1|
  if BROWSER.image(:alt,arg1).exist?
    puts arg1
    BROWSER.goto "alpha.akhoni.com"
  end
end

######################## Step Definitions Then The page should show "" ###################################

Then /^The page should show "([^\"]*)"$/ do |arg1|
   if BROWSER.div(:class,arg1)
    puts "OKK"
  end
end
When /^I click to the link "([^\"]*)"$/ do |arg1|
  if BROWSER.link(:text,arg1).exist?
    BROWSER.link(:text,arg1).click
  end
end