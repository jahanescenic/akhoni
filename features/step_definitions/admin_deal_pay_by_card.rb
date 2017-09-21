$pay_by_card = 1
$deal_title = ""

############ Step definitions for Then /^I edit a deal and "" pay by card option$/ ##################################

Then /^I edit a deal and "([^\"]*)" pay by card option$/ do |action|
  BROWSER.link(:text, "Edit").click if BROWSER.link(:text, "Edit").exist?
  if action=="deactivate"
    puts "entered D"
    BROWSER.checkbox(:id, "deal_is_pay_by_card").clear
    $pay_by_card = 0
  elsif action=="activate"
     puts "entered A"
    BROWSER.checkbox(:id, "deal_is_pay_by_card").set
    $pay_by_card = 1
  end
  @year = ["2011", "2012", "2013", "2014", "2015", "2016", "2017"]
  @month = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"]
  @day = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30"]
  @hour = ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23"]
  @minute = ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59"]
  year_end = @year[rand(@year.length)]
  month_end = @month[rand(@month.length)]
  day_end = @day[rand(@day.length)]
  hour_end =@hour[rand(@hour.length)]
  minute_end =@minute[rand(@minute.length)]
  year_start = BROWSER.select_list(:id, "deal_start_date_1i").value
  while (year_end<=year_start)
    year_end = @year[rand(@year.length)]
  end
  And "I enter a date and time with following records", table(%{
       | id                   | value         |
       |deal_end_date_1i      |#{year_end}    |
       |deal_end_date_2i      |#{month_end}   |
       |deal_end_date_3i      |#{day_end}     |
       |deal_end_date_4i      |#{hour_end}    |
       |deal_end_date_5i      |#{minute_end}  |
  })                                                                                                            ## admin_deal.rb
  And "I enter a date and time with following records", table(%{
       | id                   | value         |
       |deal_valid_to_1i      |#{year_end}    |
       |deal_valid_to_2i      |#{month_end}   |
       |deal_valid_to_3i      |#{day_end}     |
       |deal_valid_to_4i      |#{hour_end}    |
       |deal_valid_to_5i      |#{minute_end}  |
  })                                                                                                           ## admin_deal.rb
  BROWSER.select_list(:id, "deal_status").select_value("approved")
  $deal_title = BROWSER.text_field(:id, "deal_title").text
  BROWSER.button(:id, "deal_submit").click
  puts $pay_by_card
  puts $deal_title
end
############ Step definitions for Then /^I click on "" link$/ ##################################

Then /^I click on "([^\"]*)" link$/ do |arg1|
  if BROWSER.link(:text, arg1).exist?
    BROWSER.link(:text, arg1).click
  end

end

######################## Step Definitions Then "I check \"\" and \"\"" ################################

Then /^I check "([^\"]*)" and "([^\"]*)"$/ do |pay_by_card,pay_bkash|
  if $pay_by_card == 0
    if BROWSER.radio(:id, pay_by_card).exist? && BROWSER.radio(:id, pay_bkash).exist?
      puts "pay by card is disabled but showing.......WRONG"
    else
      puts "pay by card is disabled and not showing.......RIGHT"
    end
  elsif $pay_by_card == 1
    if BROWSER.radio(:id, pay_by_card).exist? && BROWSER.radio(:id, pay_bkash).exist?
      puts "pay by card is enabled and showing.......RIGHT"
    else
      puts "pay by card is enabled and not showing.......WRONG"
    end
  end
end

#################### Step definitions for  "Then I check pay by card option in frontend" ########################

Then /^I check pay by card option in frontend$/ do
  $deal_title = "q3MMZHvEeTEvdb8yFngQ"
  When "i go to url \"http://alpha.akhoni.com\""                                                                ##sign_up.rb

  if BROWSER.link(:text, $deal_title).exist?
    BROWSER.link(:text, $deal_title).click
  end
  And "I click to place an order by clicking Buy"                                                               ##my_steps.rb
  And "I can change the quantity with value \"1\" if i'm on the \"Your Purchase\" page"                         ##my_steps.rb
  Then "I am in \"Your Purchase\" page and I will click buy and go to the page \"Your Order Details\""          ##my_steps.rb
  And "I will fill the following user records", table(%{

    | name_error                             | phone_error                 | address_error               |
    | Firstname can not be blank.            | Phone can not be blank.     | Address can not be blank.   |

   })                                                                                                          ##my_steps.rb
  Then "I am in \"Your Purchase\" page and I will click buy and go to the page \"Your Order Details\""         ##my_steps.rb
  Then "I check \"pay_cash_by_credit_debit_card\" and \"pay_cash_by_mobile\""
end