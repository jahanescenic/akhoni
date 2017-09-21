def random_string(length)
  chars = '_.abcdefghjkmnpqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ23456789'
  password = ''
  length.times { password << chars[rand(chars.size)] }
  password

end

def random_number(length)
  numbers = '0123456789'
  phone = ''
  length.times { phone << numbers[rand(numbers.size)] }
  phone
end

############################ step definitions Then I click on "" #####################

When /^I click on "([^"]+)"$/ do |text|
  if BROWSER.contains_text("Welcome")

    BROWSER.goto "alpha.akhoni.com/users/sign_out"
    puts "Signed out...................."
  end
  BROWSER.link(:text, text).click if BROWSER.link(:text, text).exist?
end

############################ Step Definitions When "i entered \"\" and \"\" and \"\" and \"\"" ###############

When /^i entered "([^"]*)" and "([^"]*)" and "([^"]*)" and "([^"]+)"$/ do |user, phone_number, pass, pass_conf|

  BROWSER.text_field(:id, "user_email").set(user)

  BROWSER.text_field(:id, "user_phone").set(phone_number)

  BROWSER.text_field(:id, "user_password").set(pass)

  BROWSER.text_field(:id, "user_password_confirmation").set(pass_conf)

end

########################## Step Definitions And "i submit with \"\"" ########################

And /^i submit with "([^"]+)"$/ do |text|
  if BROWSER.checkbox(:id, "agree").exist?
    BROWSER.checkbox(:id, "agree").set
  end
  BROWSER.button(:value, text).click
end

######################### Step Definitions Then "The page says \"\"" ##############

When /^The page says "([^"]+)"$/ do |text|

  if BROWSER.contains_text(text) then

    puts text

  end

end

############################## Step Definitions Given the following user records #########################

Given /^the following user records$/ do |table|

  # table is a | test_user1@example.com      | secret   | secret |
  table.hashes.each do |hash|

    at_d = hash["username"]
    if at_d != ""
      at_dot = at_d.split(",")
      @host = ["yahoo", "gmail", "baz", "dolor", "lorem", "ipsum"]
      @tld = ["com", "org", "net", "us", "tl"]
      user_email = random_string(10)

      host = @host[rand(@host.length)]
      tld = @tld[rand(@tld.length)]
      if (at_dot[0]!= nil && at_dot[1]!=nil) then
        @user = user_email+at_dot[0]+host+at_dot[1]+tld
      else
        @user = user_email.clone
      end
      puts @user
    else
      @user = ""
    end
    pass = hash["password"]

    pass_conf = hash["password_confirmation"]

    phone = hash["phone"]
    valid_phone_number = phone.split(",")
    puts valid_phone_number[0]+random_number(valid_phone_number[1].to_i)
    @phone_number = valid_phone_number[0]+random_number(valid_phone_number[1].to_i)
    puts @phone_number
    messeges = hash["errors"]

    When "i entered \"#{@user}\" and \"#{@phone_number}\" and \"#{pass}\" and \"#{pass_conf}\""

    And "i submit with \"Sign Up\""

    Then "The page says \"#{messeges}\""

  end

end

########################## Step Definitions When i go to url "<url>" ############################

When /^i go to url "([^"]+)"$/ do |arg1|

  BROWSER.goto arg1

end