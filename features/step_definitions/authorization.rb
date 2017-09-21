####################### Step Definitions Then "I click to Redeem button to verify the coupon with \"\"" #############

Then /^I click to Redeem button to verify the coupon with "([^"]*)"$/ do |verification_code|
  if BROWSER.div(:class, "button_inside_border_blue button_redeem").exist?
    BROWSER.div(:class, "button_inside_border_blue button_redeem").click
  end
  BROWSER.text_field(:id, "code_verification").set verification_code
  if BROWSER.button(:text, "Verify").exist?
    BROWSER.button(:text, "Verify").click
  end
  if BROWSER.table(:class, "list").exist?
    if BROWSER.table(:class, "list").row(:index, 2)[8].text=="Redeemed"
      puts "Redeemed"
    end
  end
end

######################## Step Definitions Then "i can go to \"\"" #####################

Then /^i can go to "([^"]*)"$/ do |text|

  BROWSER.link(:text, text).click if BROWSER.link(:text, text).exist?

end

###################### Step Definitions Then "i enter the \"\"" ##################

Then (/i enter the "([^"]*)"$/) do |coupon_code|
  coupon_code_value = coupon_code.split("# ")
  coupon_no = coupon_code_value[1].split("-")
  BROWSER.text_field(:id, "search_security_code_coupon_contains").set coupon_no[0]
  BROWSER.button(:id, "search_submit").click if BROWSER.button(:id, "search_submit").exist?
  Then "I click to Redeem button to verify the coupon with \"#{coupon_no[1]}\""
end

###################### Step Definitions Then "I will go to following links  ####################

Then (/^I will go to following links$/) do |table|
  table.hashes.each do |hash|
    link = hash["link"]
    title = hash["title_of_the_page"]
    cancel_back = hash["cancel_button"]
    puts link+title+cancel_back
    if link=="Current Deals"
      Then "The Page Should show Multiple deals or Single deal"                          ##search_steps.rb
    else
      Then "i can go to \"#{link}\""
      Then "The Page Should Say \"#{title}\""                                            ##search_steps.rb
      if link=="ORDER"
        #And "I choose a order from the \"\" and check whether it is paid or not"
      end
      if link=="Coupons"
        BROWSER.link(:text, "Coupon").click if BROWSER.link(:text, "Coupon").exist?
        @coupon_code = BROWSER.div(:id, "coupon_code").text
        puts @coupon_code
        sleep 10
        When "i go to url \"alpha.akhoni.com/manage/coupons\""                           ##sign_up.rb
        BROWSER.link(:text, "Resend").click if BROWSER.link(:text, "Resend").exist?
      end
      if link=="Featured Requests"
        When "i go to url \"alpha.akhoni.com/manage/businesses/1\""                    ## sign_up.rb
        if BROWSER.contains_text("Basic Information") && BROWSER.contains_text("Contact Information")
          puts "entered to business"
        end
      end
      if link == "collections"
        if BROWSER.contains_text("Filter Payments")
          if BROWSER.table(:class, "list").exist?
            puts "collector's collection shown......."
          end
        else
          puts "failed"
        end
      end
      if cancel_back!=""
        BROWSER.link(:text, cancel_back).click
      end
    end
  end
end

###################### Step Definitions Then I give The following user records #####################

Then /^I give The following user records$/ do |table|
  table.hashes.each do |hash|
    user = hash["username"]
    pass = hash["password"]

    Then "I click on \"Sign In\""
    BROWSER.text_field(:id, "user_login").set user
    BROWSER.text_field(:id, "user_password").set pass
    BROWSER.button(:id, "user_submit").click
#    Then "I will go to following links", table(%{
#         | link                   | title_of_the_page   |  cancel_button |
#         |  Feature your Business |Feature your business             |  |
#         |  Recent deals          |Recent Deals                      |  |
#         |  About                 | About akhoni                     |  |
#         |  Current Deals         |                                  |  |
#         |  How it works          |How Akhoni.com works?             |  |
#         |  Referral Program      |Refer friends!                    |  |
#
#         |  Press                 |Press Coverage                    |  |
#
#         |  Referrals History     |Refer friends!                    |   |
#         |  Contact us            |Contact Information               |  |
#         |  Terms of use          |Terms and conditions              |  |
#         |  Career                  |Career Opportunities With Akhoni.com| |
#        })
    case user
      when "deal_admin@akhoni.com"
        And "I go to \"alpha.akhoni.com/manage\""                                   ##my_steps.rb
        Then "I will go to following links", table(%{
         | link                   | title_of_the_page                | cancel_button  |
         | Show All               | Displaying all                   |                |
         | New Deal               | Create Deal                      | Cancel         |
         | Edit                   | Edit Deal                        | Cancel         |
         | Ordering               | Drag To Change Deal Order        |                |
         | Products               | Displaying all                   |                |
         | New Product            | New Product                      | Cancel         |
         | Edit                   | Edit Product                     | Cancel         |
         | Merchants              | Displaying all                   |                |
         | New Merchant           | New Merchant                     | Cancel         |
         | Edit                   | Edit Merchant                    | Cancel         |
         | Email Logs             | Filter Email Notification Logs   |                |
         | Notifications          | Displaying notifications         |                |
         | New Notification       | New Notification                 | Cancel         |
         | Edit                   | Edit Notification                | Cancel         |
         | Test                   | Test notification sent to your email address.|       |
         | Assign Users           | Filter/Assign Users              | Cancel         |
         | Notices                | Displaying all                   |                |
         | New Notice             | New Notice                       | Cancel         |
         | Edit                   | Edit Notice                      |                |
         | HOME                   | Current Deals                    | Admin Panel    |

         | Background Image       | Upload Background Image          |                |
         | Add New Merchant       | New Merchant                     |                |
         | Add New Deal           | Create Deal                      |                |
         | Schedule Notification  | New Notification                 |                |
        })
      when "merchant@akhoni.com"
        And "I click to place an order by clicking Buy"                                          ##my_steps.rb
        And "I can change the quantity with value \"1\" if i'm on the \"Your Purchase\" page"    ##my_steps.rb
        Then "I am in \"Your Purchase\" page and I will click buy and go to the page \"Your Order Details\"" ##my_steps.rb
        Then "I \"pay_cash_by_credit_debit_card\" and press \"pay_now\""                                     ##my_steps.rb
        And "if i'm in \"sslcommerzlogo\" site then press for \"nexus\" transaction and click on \"Proceed to Pay\" button and expect \"Success Transaction\""  ##my_steps.rb
        Then "i click on \"Success Transaction\" and search for the text \"Coupon Code\""     ##my_steps.rb
        if BROWSER.div(:id, "coupon_code").exist?
          @coupon_code = BROWSER.div(:id, "coupon_code").text
          puts @coupon_code
        end
        sleep 10
        And "I go to \"http://alpha.akhoni.com/merchant/1/coupons\""                         ##my_steps.rb
        Then "i enter the \"#{@coupon_code}\""

      when "collector@akhoni.com"
        And "I go to \"alpha.akhoni.com/manage\""                                           ##my_steps.rb
        Then "I will go to following links", table(%{
         | link                   | title_of_the_page                | cancel_button  |
         | ORDER                  | Displaying orders                |                |
         | Coupons                | Displaying coupons               |                |
         | Mobile Transactions    | Listing Mobile Transactions      |                |
         | New Mobile transaction | New Mobile Transaction           |  Cancel        |
         | Edit                   | Edit Mobile Transaction          |  Cancel        |
         | Clear Cache            | Cache was deleted successfully   |                |
       })
      when "copywriter@akhoni.com"
        And "I go to \"alpha.akhoni.com/manage\""                                             ##my_steps.rb
        Then "I will go to following links", table(%{
         | link                   | title_of_the_page                | cancel_button  |
         | Show All               | Displaying all                   |                |
         | New Deal               | Create Deal                      | Cancel         |
         | Edit                   | Edit Deal                        | Cancel         |
         | Merchants              | Displaying all                   |                |
         | New Merchant           | New Merchant                     | Cancel         |
         | Edit                   | Edit Merchant                    | Cancel         |
         | Add New Merchant       | New Merchant                     |                |
         | Add New Deal           | Create Deal                      | Cancel         |
      })
      when "crm@akhoni.com"
        And "I go to \"alpha.akhoni.com/manage\""                                            ##my_steps.rb
        Then "I will go to following links", table(%{
         | link                   | title_of_the_page                | cancel_button  |
         | Show All               | Displaying all                   |                |
         | New Deal               | Create Deal                      | Cancel         |
         | Edit                   | Edit Deal                        | Cancel         |
         | Ordering               | Drag To Change Deal Order        |                |
         | Products               | Displaying all                   |                |
         | New Product            | New Product                      | Cancel         |
         | Edit                   | Edit Product                     | Cancel         |
         | Merchants              | Displaying all                   |                |
         | New Merchant           | New Merchant                     | Cancel         |
         | Edit                   | Edit Merchant                    | Cancel         |
         | Featured Requests      | Displaying all                   |                |
         | Background Image       | Upload Background Image          |                |
         | Clear Cache            | Cache was deleted successfully   |                |
         | Add New Merchant       | New Merchant                     |                |
         | Add New Deal           | Create Deal                      | Cancel         |
        })
      when "analyst@akhoni.com"
        And "I go to \"alpha.akhoni.com/manage\""                                         ##my_steps.rb
        Then "I will go to following links", table(%{
         | link                   | title_of_the_page                | cancel_button  |
         | Show All               | Displaying all                   |                |
         | New Deal               | Create Deal                      | Cancel         |
         | Edit                   | Edit Deal                        | Cancel         |
         | Ordering               | Drag To Change Deal Order        |                |
         | Merchants              | Displaying all                   |                |
         | New Merchant           | New Merchant                     | Cancel         |
         | Edit                   | Edit Merchant                    | Cancel         |
         | Email Logs             | Filter Email Notification Logs   |                |
         | Notices                | Displaying all                   |                |
         | New Notice             | New Notice                       | Cancel         |
         | Edit                   | Edit Notice                      |                |
         | Background Image       | Upload Background Image          |                |
         | ORDER                  | Displaying orders                |                |
         | Coupons                | Displaying coupons               |                |
         | Collections            |                                  |                |
        })
    end

  end
end
