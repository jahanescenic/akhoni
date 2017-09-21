def random_string(length)
  chars = '.abcdefghjkmnpqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ23456789'
  text = ''
  length.times { text << chars[rand(chars.size)] }
  text
end

def random_address(length)
  chars = '<>?:{}!@#$%^&*()=_.abcdefghjkmnpqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ23456789'
  text = ''
  length.times { text << chars[rand(chars.size)] }
  text
end

def random_number(length)
  number = '1234567890'
  num = ''
  length.times { num << number[rand(number.size)] }
  num
end

########################## Step definitions When "i entered \"#{phone}\" and \"#{password}\" and \"#{password_confirmation}\" and \"#{firstname}\" and \"#{lastname}\" and \"#{address}\"" #################

Given /^i entered "([^\"]*)" and "([^\"]*)" and "([^\"]*)" and "([^\"]*)" and "([^\"]*)" and "([^\"]*)"$/ do |phone_number, pass, pass_conf, first, last, address|

  BROWSER.text_field(:id, "user_firstname").set first

  BROWSER.text_field(:id, "user_lastname").set last

  BROWSER.text_field(:id, "user_address").set address

  BROWSER.text_field(:id, "user_phone").set phone_number

  BROWSER.text_field(:id, "user_password").set pass

  BROWSER.text_field(:id, "user_password_confirmation").set pass_conf

  BROWSER.button(:id, "user_submit").click if BROWSER.button(:id, "user_submit").exist?

end

#################### Step definitions And I sign in with "" and "" ####################

When /^I sign in with "([^\"]*)" and "([^\"]*)"$/ do |arg1, arg2|
  if BROWSER.text_field(:id, "user_login").exist?
    BROWSER.text_field(:id, "user_login").set arg1
  end
  if BROWSER.text_field(:id, "user_password").exist?
    BROWSER.text_field(:id, "user_password").set arg2
  end
  BROWSER.button(:id, "user_submit").click if BROWSER.button(:id, "user_submit").exist?


end

########################### Step Definitions Given The following user update records ######################

Given /^The following user update records$/ do |table|

  table.hashes.each do |hash|
    phone = hash["phone"]
    password = hash["password"]
    password_confirmation = hash["password_confirmation"]
    messeges = hash["messeges"]
    firstname = random_string(10)
    lastname = random_string(10)
    address = random_address(30)
    if phone == "blank"
      phone = ''
      puts "BLANK"
    elsif phone=="random_valid"
      @operators = ["017", "015", "016", "018", "019", "016", "011"]
      phone = @operators[rand(@operators.length)] + random_number(8)
      puts phone
    elsif phone == "random_invalid"
      phone = random_number(11)
      puts phone
    elsif phone == "random_wrong_length"
      phone = random_number(9)
      puts phone
    end

    When "i entered \"#{phone}\" and \"#{password}\" and \"#{password_confirmation}\" and \"#{firstname}\" and \"#{lastname}\" and \"#{address}\""

    Then "The page says \"#{messeges}\""                              ##sign_up.rb

    Then "I go to \"alpha.akhoni.com/settings\""                      ##my_steps.rb
  end
  Then "I go to \"alpha.akhoni.com\""                                 ##my_steps.rb
end