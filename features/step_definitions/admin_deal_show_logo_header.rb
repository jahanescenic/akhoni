$header = "GIFT VOUCHER"

############ Step definitions for Then /^I edit a deal and know the merchant name$/ ##################################

Then /^I edit a deal and know the merchant name$/ do
  BROWSER.link(:text, "Edit").click if BROWSER.link(:text, "Edit").exist?
  $deal_title = BROWSER.text_field(:id, "deal_title").text
  $merchant_id = BROWSER.select_list(:id, "deal_merchant_id").value
  puts $merchant_id
  puts $deal_title
  BROWSER.text_field(:id, "deal_coupon_header").set $header
  BROWSER.button(:id, "deal_submit").click
  BROWSER.goto "alpha.akhoni.com/manage/merchants/#{$merchant_id}/edit"
  BROWSER.file_field(:id, "merchant_pictures_attributes_index_to_replace_with_js_data").set("F:\\Working\\deal pics\\tiny_logo.gif")
  BROWSER.button(:id, "merchant_submit").click
end

############ step definitions for "Then "I search for logo and coupon" ##################################

Then /^I search for logo and coupon$/ do
  if BROWSER.text.include? $header
    puts "HEADER SHOWN"
  end
  if BROWSER.image(:alt,"Small_tiny_logo").exist?
    puts "LOGO SHOWN"
  end
end
############ Step definitions for Then /^I check the coupon for logo and header/ ##################################

Then /^I check the coupon for logo and header$/ do
  When "i go to url \"http://alpha.akhoni.com\""                                                                  ##sign_up.rb
  if BROWSER.link(:text, $deal_title).exist?
    BROWSER.link(:text, $deal_title).click
  end
  And "I click to place an order by clicking Buy"                                                                 ##my_steps.rb
  And "I can change the quantity with value \"1\" if i'm on the \"Your Purchase\" page"                           ##my_steps.rb
  Then "I am in \"Your Purchase\" page and I will click buy and go to the page \"Your Order Details\""            ##my_steps.rb
  And "I will fill the following user records", table(%{

    | name_error                             | phone_error                 | address_error               |
    | Firstname can not be blank.            | Phone can not be blank.     | Address can not be blank.   |

   })                                                                                                             ##my_steps.rb
  Then "I am in \"Your Purchase\" page and I will click buy and go to the page \"Your Order Details\""            ##my_steps.rb
  Then "I \"pay_cash_by_credit_debit_card\" and press \"pay_now\""                                                ##my_steps.rb
  And "if i'm in \"sslcommerzlogo\" site then press for \"nexus\" transaction and click on \"Proceed to Pay\" button and expect \"Success Transaction\"" ##my_steps.rb
  Then "i click on \"Success Transaction\" and search for the text \"Coupon Code\""                               ##my_steps.rb
  sleep 10
  Then "I search for logo and coupon"
end