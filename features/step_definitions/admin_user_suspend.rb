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

######################## Step Definitions Then I search for an user and suspend the user #######################

Then /^I search for an user and suspend the user$/ do
  if BROWSER.text_field(:id, "search_email_or_firstname_or_lastname_or_phone_contains").exist?
    BROWSER.text_field(:id, "search_email_or_firstname_or_lastname_or_phone_contains").set $user
  end
  Then "I \"search_submit\" the search"
  if BROWSER.link(:text, "suspend").exist?
    BROWSER.link(:text, "suspend").click
  end
  if BROWSER.text.include? "has been suspended."
    puts "Suspension Successful"
  end
end

################# Step definitions Then I should see the homepage without signed in ####################

Then /^I should see the homepage without signed in$/ do
  if not BROWSER.text.include? "Welcome"
    if  BROWSER.link(:text, "Sign In").exist?
      puts "Suspended user can not login"
    end
  end
end

######################### Step Definitions Then I will sign up with random user generation ######################

Then /^I will sign up with random user generation$/ do
  @host = ["yahoo", "gmail", "baz", "dolor", "lorem", "ipsum"]
  @tld = ["com", "org", "net", "us", "tl"]
  user_email = random_string(10)
  host = @host[rand(@host.length)]
  tld = @tld[rand(@tld.length)]
  $user = user_email+"@"+host+"."+tld
  $pass = "secret"
  $pass_conf = "secret"
  @phone_types = ["017", "018", "015", "016", "011", "019"]

  $phone_number = @phone_types[rand(@phone_types.length)] + random_number(8)
  When "i entered \"#{$user}\" and \"#{$phone_number}\" and \"#{$pass}\" and \"#{$pass_conf}\""           ##sign_up.rb
  And "i submit with \"Sign Up\""                                                                         ##sign_up.rb
  Then "The page says \"Welcome\""                                                                        ##sign_up.rb
end