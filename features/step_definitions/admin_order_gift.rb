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

################################### Step Definitions  When I want to buy for my friend ########################

When /^I want to buy for my friend$/ do
  if BROWSER.checkbox(:id, "friend_info").exist?
    BROWSER.checkbox(:id, "friend_info").set
    @host = ["yahoo", "gmail", "baz", "dolor", "lorem", "ipsum"]
    @tld = ["com", "org", "net", "us", "tl"]
    @phone_host = ["018", "017", "015", "019", "011", "016"]
    @address1 = random_number(2)
    @address2 = random_string(10)
    @address3 = random_string(10)
    friend_firstname = random_string(20)
    friend_lastname = random_string(20)
    @email = random_string(10)
    host = @host[rand(@host.length)]
    tld  = @tld[rand(@tld.length)]
    friend_email = "#{@email}@#{host}.#{tld}"
    friend_phone = @phone_host[rand(@phone_host.length)]+random_number(8)
    friend_address = "Road-"+@address1+","+@address2+","+@address3
    BROWSER.text_field(:id, "friend_firstname").set friend_firstname
    BROWSER.text_field(:id, "friend_lastname").set friend_lastname
    BROWSER.text_field(:id, "friend_email").set friend_email
    BROWSER.text_field(:id, "friend_phone").set friend_phone
    BROWSER.text_field(:id, "friend_address").set friend_address


  end
end

######################### Step Definitions And I want to search with the coupon code and check the gift field ###############

When /^I want to search with the coupon code and check the gift field$/ do
  $coupon_code[0] = $coupon_code[0].to_s
  BROWSER.text_field(:id, "search_security_code_booking_or_coupons_security_code_coupon_contains").set $coupon_code[0]
  Then "I \"search_submit\" the search"
  And "I want to know the column number of \"Gift?\" of \"list\" from index number \"1\""
  $gift = $column_number
  Then "I check \"Yes\" in \"list\" in \"#{$gift}\""
end