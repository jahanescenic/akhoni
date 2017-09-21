
########################## Step Definitions  Then I want to see "More Deals" ########################

Then /^I want to see "([^\"]*)"$/ do |arg1|
 if BROWSER.text.include? (arg1) then
   link = BROWSER.li(:class,"deal").link(:index,1).href
   text = BROWSER.li(:class,"deal").link(:index,1).text

   BROWSER.link(:href,link).click
   if BROWSER.contains_text(text)
     if BROWSER.div(:class,"main_deal")
       puts "Deal description OKK"
     end
     if BROWSER.div(:class,"location")
       puts "Location OKK"
     end
   end
 end
end