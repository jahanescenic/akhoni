def random_string(length)
  chars = '_.abcdefghjkmnpqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ23456789'
  name = ''
  length.times { name << chars[rand(chars.size)] }
  name

end

def random_number(length)
  numbers = '0123456789'
  phone = ''
  length.times { phone << numbers[rand(numbers.size)] }
  phone
end

def random_mobile_subscriber(length)
  numbers = '78'
  mobile = ''
  length.times { mobile << numbers[rand(numbers.size)] }
  mobile
end

############################## Step Definitions Then I set "checkout_use_referral" ################################

Then /^I set "([^\"]*)"$/ do |arg1|
  if  BROWSER.checkbox(:id, arg1).exist?
    BROWSER.checkbox(:id, arg1).set
  end
end

############################# Step Definitions Then "I set radio button \"need_shipping\"" ########################

Then /^I set radio button "([^\"]*)"$/ do |arg1|
  if  BROWSER.radio(:id, arg1).exist?
    BROWSER.radio(:id, arg1).set
  end
end

################################# Step Definitions Then "I fill the booking code field with \"#{@booking_code}\"" ############################

Then (/^I fill the booking code field with "([^"]+)"$/) do |booking_code|
  BROWSER.text_field(:name, "search[security_code_booking_or_coupons_security_code_coupon_contains]").set booking_code
  BROWSER.button(:id, "search_submit").click
  if BROWSER.link(:text, "Confirmed").exist?
    BROWSER.link(:text, "Confirmed").click
    if BROWSER.div(:id, "notice").text.include? "confirmed successfully."
      puts "Confirm OKK"
      if BROWSER.link(:text, "Delivered").exist?
        BROWSER.link(:text, "Delivered").click
        if BROWSER.div(:id, "notice").text.include? "Payment information saved successfully"
          puts "Paid OKK"
          if BROWSER.link(:text, "Coupon").exist?
            BROWSER.link(:text, "Coupon").click
            @coupon_code = BROWSER.div(:id, "coupon_code").text
            puts @coupon_code
          else
            puts BROWSER.div(:id, "notice").text
          end
        else
          puts BROWSER.div(:id, "notice").text
        end
      end
    else
      puts BROWSER.div(:id, "notice").text
    end
  end
end

########################### Step Definitions When "I go to \"alpha.akhoni.com/manage/mobile_transactions\"" ##########################

When /^I go to "([^\"]*)"$/ do |arg1|

  BROWSER.goto arg1
  if BROWSER.text.include? "Filter Payments"
    $no_of_case = 18
  end
end

######################### Step Definitions When "I go for a \"New Mobile transaction\"" ###############################################

When /^I go for a "([^"]+)"$/ do |arg1|
  puts arg1
  if BROWSER.link(:text, arg1).exist?
    BROWSER.link(:text, arg1).click
    puts "Enter" + arg1
  end

end

######################## Step Definitions Then "I give the entry of \"#{@mobile_no}\" \"#{@o_amount}\" \"#{@transaction_id}\"" #########################

Then (/^I give the entry of "([^"]+)" "([^"]+)" "([^"]+)"$/) do |mobile_no, amount, trans_id|

  BROWSER.text_field(:id, "mobile_transaction_mobile_number").set mobile_no
  BROWSER.text_field(:id, "mobile_transaction_amount").set amount
  BROWSER.text_field(:id, "mobile_transaction_transaction_id").set trans_id
  if BROWSER.button(:id, "mobile_transaction_submit").exist?
    BROWSER.button(:id, "mobile_transaction_submit").click
    if BROWSER.div(:id, "notice").text == "Mobile Transaction was successfully created."
      puts "Successful entry from Admin"
    end
  end
end

############################# Step Definitions Then "I fill the booking code field with \"#{@booking_code}\" and check the coupon" ######################

Then (/^I fill the booking code field with "([^"]+)" and check the coupon$/) do |booking_code|

  BROWSER.text_field(:name, "search[security_code_booking_or_coupons_security_code_coupon_contains]").set booking_code
  BROWSER.button(:id, "search_submit").click
  if BROWSER.link(:text, "Confirmed").exist?
    puts "Invalid mobile transaction"
  elsif BROWSER.link(:text, "Coupon").exist?
    BROWSER.link(:text, "Coupon").click
    @coupon_code = BROWSER.div(:id, "coupon_code").text
    puts @coupon_code
    puts "Transaction Successful"
  else
    puts BROWSER.div(:id, "notice").text
  end

end

######################### Step Definitions And  I click to place an order by clicking Buy #######################

When(/^I click to place an order by clicking Buy$/) do
  if  BROWSER.div(:class, "multiple-deal-wrap").exist?
    BROWSER.link(:text, "View Details & Buy").click
  end
  if BROWSER.div(:class, "buy_now").link(:class, "button").exist?

    BROWSER.div(:class, "buy_now").link(:class, "button").click
    if  BROWSER.link(:class, "button sub-deal-buy").exist?
      BROWSER.link(:class, "button sub-deal-buy").click

      puts "Enteredddd" if BROWSER.contains_text("Your Purchase")
    elsif BROWSER.div(:class, "product_image_hover_wrapper").exist?
      if BROWSER.link(:class, "multiple-product").exist?
        BROWSER.link(:class, "multiple-product").click
      end
      if BROWSER.link(:class, "buy_now_btn").exist?
        BROWSER.link(:class, "buy_now_btn").click
      end
    end
  elsif  BROWSER.div(:class, "buy_now").link(:class, "button closed").exist?
    puts "SOLD OUT"
  end

end

####################### Step Definitions And  May be I need to sign in with my "<name>" and "<secret>" ##############################

When(/^May be I need to sign in with my "([^"]+)" and "([^"]+)"$/) { |name, secret|
  if (BROWSER.contains_text("You need to sign in or sign up before continuing.")) or BROWSER.contains_text("Sign In") then
    BROWSER.text_field(:name, "user[login]").set name
    BROWSER.text_field(:name, "user[password]").set secret
    BROWSER.button(:value, "Sign In").click
    puts "registration OK" if BROWSER.contains_text("Signed in successfully.")
  end }

######################## Step Definitions And  I will fill the following user records ###################################

When /^I will fill the following user records$/ do |table|

  if BROWSER.div(:id, "error_explanation").exist?
    puts "Error Found"
    table.hashes.each do |hash|
      @name_error = hash["name_error"]
      @phone_error = hash["phone_error"]
      @address_error = hash["address_error"]

      @phone_host = ["018", "017", "015", "019", "011", "016"]
      if (BROWSER.text.include?(@name_error) && @name_error!= nil)
        @name = random_string(10)
        BROWSER.text_field(:id, "user_firstname").set @name
      end
      if BROWSER.text.include?(@phone_error)
        @phone_host = @phone_host[rand(@phone_host.length)]
        @phone = random_number(11)
        @phone_number = @phone_host+@phone
        BROWSER.text_field(:id, "user_phone").set @phone_number
      end
      if BROWSER.text.include?(@address_error)
        @address1 = random_number(2)
        @address2 = random_string(10)
        @address3 = random_string(10)
        @address = "Road-"+@address1+","+@address2+","+@address3
        BROWSER.text_field(:id, "user_address").set @address
      end
      puts @name
      puts @address
    end

  end
end

################################ Step Definitions Then I am in "Your Purchase" page and I will click buy and go to the page "Your Order Details" ########################

Then /^I am in "([^"]+)" page and I will click buy and go to the page "([^"]+)"$/ do |arg1, arg4|
  if  BROWSER.contains_text(arg1) then
    BROWSER.checkbox(:id, "agree").set
    Then "I set radio button \"need_shipping\""

    BROWSER.button(:id, "order_submit").click
    puts "YOUR PURCHASE OK" if BROWSER.contains_text(arg4)
  end

end

########################################### Step Definitions Then I "pay_cash_on_coupon_deal_delivery" or "Pay Cash On Coupon/Product Delivery" and press "pay_now" #####################

Then /^I "([^"]+)" or "([^"]+)" and press "([^"]+)"$/ do |arg1, arg2, arg3|
  @amount = 0
  $charges_discounts = 0
  if BROWSER.td(:text, "Price").exist?
    amount = BROWSER.td(:text, "Price").parent.cell(:index, 1).text
    @amount = amount.to_i
    puts "Price #{@amount}"
  else
    BROWSER.td(:text, "Price (Pay in Advance)").exist?
    amount = BROWSER.td(:text, "Price (Pay in Advance)").parent.cell(:index, 1).text
    @amount = amount.to_i
    puts "Price (Pay in Advance) #{@amount}"
  end

  if BROWSER.td(:text, "Corporate Discount").exist?
    amount = BROWSER.td(:text, "Corporate Discount").parent.cell(:index, 1).text
    @amount = amount.to_i + @amount
    $charges_discounts = amount.to_i + $charges_discounts
    puts "Corporate Discount #{@amount}"
  end


  if BROWSER.td(:text, "Shipping cost").exist?
    amount = BROWSER.td(:text, "Shipping cost").parent.cell(:index, 1).text
    @amount = amount.to_i + @amount
    $charges_discounts = amount.to_i + $charges_discounts
    puts "Shipping cost #{@amount}"
  end
  if BROWSER.td(:text, "Referral Credit").exist?
    amount = BROWSER.td(:text, "Referral Credit").parent.cell(:index, 1).text
    $referral_balance = amount
    puts $referral_balance
    @amount = amount.to_i + @amount
  end
  puts "Total amount #{@amount}"

  if  BROWSER.radio(:id, arg1).exist?
    BROWSER.radio(:id, arg1).set
  elsif BROWSER.radio(:id, arg2).exist?
    BROWSER.radio(:id, arg2).set
  end
  BROWSER.button(:id, arg3).click if BROWSER.button(:id, arg3).exist?

  if BROWSER.div(:id, "booking_details").exist?
    @booking_code=BROWSER.div(:id, "booking_details").table(:index=>0).row(:index=>4)[2].text
    puts @booking_code
    And "I go to \"http://alpha.akhoni.com/manage\" if i don't need to \"Sign In\" with \"admin_user@akhoni.com\" and \"secret\"" ##admin_order_list.rb
    And "I click on \"ORDER\" and select \"List\"" ##admin_order_list.rb
    Then "I fill the booking code field with \"#{@booking_code}\""
  end
end

############################ Step Definitions Then I "pay_cash_by_credit_debit_card" and press "pay_now" #########################

Then(/^I "([^\"]*)" and press "([^\"]*)"$/) { |arg1, arg2|
  @amount = 0
  $charges_discounts = 0
  if BROWSER.td(:text, "Price").exist?
    amount = BROWSER.td(:text, "Price").parent.cell(:index, 1).text
    @amount = amount.to_i
    puts "Price #{@amount}"
  else
    BROWSER.td(:text, "Price (Pay in Advance)").exist?
    amount = BROWSER.td(:text, "Price (Pay in Advance)").parent.cell(:index, 1).text
    @amount = amount.to_i
    puts "Price (Pay in Advance) #{@amount}"
  end

  if BROWSER.td(:text, "Corporate Discount").exist?
    amount = BROWSER.td(:text, "Corporate Discount").parent.cell(:index, 1).text
    @amount = amount.to_i + @amount
    $charges_discounts = amount.to_i + $charges_discounts
    puts "Corporate Discount #{@amount}"
  end


  if BROWSER.td(:text, "Shipping cost").exist?
    amount = BROWSER.td(:text, "Shipping cost").parent.cell(:index, 1).text
    @amount = amount.to_i + @amount
    $charges_discounts = amount.to_i + $charges_discounts
     puts "Shipping cost #{@amount}"
  end

  if BROWSER.td(:text, "Referral Credit").exist?
    amount = BROWSER.td(:text, "Referral Credit").parent.cell(:index, 1).text
    $referral_balance = amount
    puts $referral_balance
    @amount = amount.to_i + @amount
  end
  if  BROWSER.radio(:id, arg1).exist?
    BROWSER.radio(:id, arg1).set
    if BROWSER.td(:text, "Credit Card Charge").exist?
      amount = BROWSER.td(:text, "Credit Card Charge").parent.cell(:index, 1).text
      @amount = amount.to_i + @amount
      $charges_discounts = amount.to_i + $charges_discounts
      puts "Credit Card Charge #{@amount}"
    end
    puts "Total amount #{@amount}"
    if arg1=="pay_cash_by_mobile"
      if BROWSER.table(:id, "mobile_wrapper").exist?

        @mobile_subscriber= "01"+random_mobile_subscriber(1)
        @mobile_no_ext=random_number(8)
        @mobile_no=@mobile_subscriber+@mobile_no_ext
        @transaction_id=random_number(10)
        BROWSER.text_field(:id, "mobile_number").set @mobile_no
        BROWSER.text_field(:id, "mobile_transaction_id").set @transaction_id
      end
    end
    BROWSER.button(:id, arg2).click if BROWSER.button(:id, arg2).exist?
    if BROWSER.div(:id, "booking_details").exist?
      @booking_code=BROWSER.div(:id, "booking_details").table(:index=>0).row(:index=>4)[2].text
      @amount=BROWSER.div(:id, "booking_details").table(:index=>0).row(:index=>3)[2].text
      @order_amount = @amount.split(" ")
      @o_amount =@order_amount[1].to_i
      puts @booking_code
      puts @o_amount
      And "I go to \"http://alpha.akhoni.com/manage\" if i don't need to \"Sign In\" with \"admin_user@akhoni.com\" and \"secret\"" ##admin_order_list.rb
      When "I go to \"alpha.akhoni.com/manage/mobile_transactions\""
      When "I go for a \"New Mobile transaction\""
      Then "I give the entry of \"#{@mobile_no}\" \"#{@o_amount}\" \"#{@transaction_id}\""
      And "I click on \"ORDER\" and select \"List\"" ##admin_order_list.rb
      Then "I fill the booking code field with \"#{@booking_code}\" and check the coupon"
    end
    puts "CREDIT CARD TRANSACTION STARTED" if BROWSER.div(:class, "sslcommerzlogo").exists?

  end }

############################### Step Definitions And  if i'm in "sslcommerzlogo" site then press for "nexus" transaction and click on "Proceed to Pay" button and expect "Success Transaction" ################

When /^if i'm in "([^"]+)" site then press for "([^"]+)" transaction and click on "([^"]+)" button and expect "([^"]+)"$/ do |arg1, arg2, arg3, arg4|
  if  BROWSER.div(:class, arg1).exists?
    BROWSER.radio(:id, arg2).set
    BROWSER.button(:value, arg3).click
    puts "Success transaction" if BROWSER.button(:value, arg4).exists?
  end
end

############################### Step Definitions Then i click on "Success Transaction" and search for the text "Coupon Code" #####################

When /^i click on "([^"]+)" and search for the text "([^"]+)"$/ do |arg1, arg2|
  BROWSER.button(:value, arg1).click
  if BROWSER.div(:id, "coupon_code").exist?
    @coupon_code = BROWSER.div(:id, "coupon_code").text
    puts @coupon_code
  end
  puts "OKK" if BROWSER.contains_text(arg2)

end

############################ Step Definitions And  I can change the quantity with value "2" if i'm on the "Your Purchase" page ###########################

When /^I can change the quantity with value "([^"]+)" if i'm on the "([^"]+)" page$/ do |arg2, arg3|

  if BROWSER.div(:class, "more_view_saving").link(:href, "javascript:void(0);").exist?
    puts "DEAL SPECIFIC PRODUCT SOLD OUT"
    BROWSER.close
  elsif BROWSER.link(:class, "buy_now_btn").exist?
    puts "BUY NOW BUTTON FOUND"
    if BROWSER.div(:class, "size_box_row").exist?
      BROWSER.button(:xpath, "//ul[@class='product-size']/li[@class='available']").click()
    end
    BROWSER.link(:class, "buy_now_btn").click
  end
  if (BROWSER.contains_text(arg3)) then
    if  BROWSER.text_field(:id, "order_quantity").exist?
      BROWSER.text_field(:id, "order_quantity").set arg2
    end
  end
end

############################ Step Definitions Then I check "Corporate Discount" ##################################

Then /^I check "([^\"]*)"$/ do |arg1|
  if BROWSER.td(:text, arg1).exist?
    puts arg1 + "successful"
  end
end