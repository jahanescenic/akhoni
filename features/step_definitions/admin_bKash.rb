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

$mobile_subscriber= "01"+random_mobile_subscriber(1)
$mobile_no_ext=random_number(8)
$mobile_no=$mobile_subscriber+$mobile_no_ext
$transaction_id=random_number(10)

####################### Step Definitions Then I enter mobile number, "" , transaction id to respective fields ###########

Then /^I enter mobile number, "([^"]+)" , transaction id to respective fields$/ do |amount|
  puts $mobile_no
  puts $transaction_id
  puts amount
  Then "I give the entry of \"#{$mobile_no}\" \"#{amount}\" \"#{$transaction_id}\""     ## my_steps.rb
end

##################### Step Definitions Then I "" and press "" and check my coupon ###############

Then /^I "([^"]+)" and press "([^"]+)" and check my coupon$/ do |arg1, arg2|
  if  BROWSER.radio(:id, arg1).exist?
    BROWSER.radio(:id, arg1).set
    if BROWSER.table(:id, "mobile_wrapper").exist?
      BROWSER.text_field(:id, "mobile_number").set $mobile_no
      BROWSER.text_field(:id, "mobile_transaction_id").set $transaction_id
    end
    BROWSER.button(:id, arg2).click if BROWSER.button(:id, arg2).exist?
    if BROWSER.div(:id, "booking_details").exist?
      puts "Test Failed or Invalid Payment"
    elsif BROWSER.div(:id, "coupon_code").exist?
      @coupon_code = BROWSER.div(:id, "coupon_code").text
      puts @coupon_code
    end
  end
end