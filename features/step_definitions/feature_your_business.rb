$case = 0
$no_of_test_case = 18
def random_string(length)
  chars = 'abcdefghjkmnpqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ'
  text = ''
  length.times { text << chars[rand(chars.size)] }
  text
end

def random_integer(length)
  number = '1234567890'
  num = ''
  length.times { num << number[rand(number.size)] }
  num
end

def random_special_chars(length)
  chars = '<>?:{}!@#$%^&*()=_'
  text = ''
  length.times { text << chars[rand(chars.size)] }
  text
end

#################### Step Definitions When "I need to sign out" ############################################

When /^I need to sign out$/ do
  if BROWSER.link(:text, "Sign out").exist?
    BROWSER.link(:text, "Sign out").click
  end
  BROWSER.link(:text, "Sign In").click if BROWSER.link(:text, "Sign In").exist?
end

################## Step Definitions Then "The page should show error" #######################################

Then /^The page should show error$/ do
  $case = $case+1
  puts $case
  if BROWSER.div(:id, "error_explanation").exist?
    puts "Error occured"

  end
end

#################### Step Definitions Then "I click to submit on \"\"" ######################

Then /^I click to submit on "([^\"]*)"$/ do |arg1|
  BROWSER.button(:id, arg1).click if BROWSER.button(:id, arg1).exist?
end

################### Step Definitions When "i entered \"\" and \"\" and \"\" and \"\" and \"\" and \"\" and \"\"" ############

Given /^i entered "([^\"]*)" and "([^\"]*)" and "([^\"]*)" and "([^\"]*)" and "([^\"]*)" and "([^\"]*)" and "([^\"]*)"$/ do |name_of_company, type_of_business, location, website, contact_person, contact_number, email_address|
  BROWSER.text_field(:id, "business_name").set name_of_company

  BROWSER.text_field(:id, "business_category").set type_of_business

  BROWSER.text_field(:id, "business_city").set location

  BROWSER.text_field(:id, "business_website").set website

  BROWSER.text_field(:id, "business_contact_person_name").set contact_person

  BROWSER.text_field(:id, "business_phone").set contact_number

  BROWSER.text_field(:id, "business_email").set email_address

end

####################### Step Definitions Then I give the following request records ###################

Then /^I give the following request records$/ do |table|

  table.hashes.each do |hash|
    @name_of_com = hash["name_of_com"]
    @type_of_business = hash["type_of_business"]
    @location = hash["location"]
    @website = hash["website"]
    @contact_person = hash["contact_person"]
    @contact_number = hash["contact_number"]
    @email_address = hash["email_address"]

    if @name_of_com=="random_valid"
      @name_of_com=random_string(10)
    elsif @name_of_com=="random_special_chars"
      @name_of_com = random_special_chars(5) + random_string(5) + random_special_chars(2) + random_string(3)
    end
    if @type_of_business == "random_valid"
      @type_of_business=random_string(10)
    elsif @type_of_business == "random_special_chrs"
      @type_of_business = random_special_chars(5) + random_string(5) + random_special_chars(2) + random_string(3)
    elsif @type_of_business == "random_invalid"
      @type_of_business=random_integer(10)
    end
    if @location=="random_valid"
      @location=random_string(10)
    elsif @location=="random_special_chars"
      @location = random_special_chars(5) + random_string(5) + random_special_chars(2) + random_string(3)
    end
    @tld = ["com", "org", "net", "us", "tl"]
    tld = @tld[rand(@tld.length)]
    if @website=="."
      @website = random_string(10)+"."+ tld
    else
      @website = random_string(10)+ tld
    end
    if @contact_person == "random_valid"
      @contact_person=random_string(10)
    elsif @contact_person == "random_special_chars"
      @contact_person = random_special_chars(5) + random_string(5) + random_special_chars(2) + random_string(3)
    elsif @contact_person == "random_invalid"
      @contact_person=random_integer(10)
    end
    operators = ["017", "018", "019", "015", "016"]
    if @contact_number == "random_valid"
      @contact_number=operators[rand(operators.length)] + random_integer(8)
    elsif @contact_number == "random_wrong_length"
      @contact_number = random_integer(5)
    elsif @contact_number == "random_invalid"
      @contact_number=random_string(10)
    end
    @email_address_final = ""
    @host = ["yahoo", "gmail", "baz", "dolor", "lorem", "ipsum"]
    host = @host[rand(@host.length)]
    user_email = random_string(10)
    if @email_address!=""
      if @email_address.include? ","
        email = @email_address.split(",")
        @email_address_final = user_email+email[0]+host+email[1]+tld
      else
        email = @email_address.clone
        if email == "@"
          @email_address_final = user_email+email+host+tld
        else
          @email_address_final = user_email+host+email+tld
        end
      end
    end
    When "i entered \"#{@name_of_com}\" and \"#{@type_of_business}\" and \"#{@location}\" and \"#{@website}\" and \"#{@contact_person}\" and \"#{@contact_number}\" and \"#{@email_address_final}\""

    Then "I click to submit on \"business_submit\""

    Then "The page should show error"

    Then "I go to \"alpha.akhoni.com/getfeatured\""                        ##my_steps.rb

    if $case == $no_of_test_case
      When "I need to sign out"
      And "May be I need to sign in with my \"admin_user@akhoni.com\" and \"secret\""       ##my_steps.rb
      BROWSER.goto "http://alpha.akhoni.com/manage/businesses"                              ##my_steps.rb
      @page = 0
      while (@page!=1)
        if BROWSER.link(:text, @name_of_com).exist?
          BROWSER.link(:text, @name_of_com).click
          @page = 1
          if BROWSER.contains_text(@type_of_business) && BROWSER.contains_text(@location) && BROWSER.contains_text(@website) && BROWSER.contains_text(@contact_person) && BROWSER.contains_text(@contact_number) && BROWSER.contains_text(@email_address_final)
            puts "successful"
          end
        else
          if BROWSER.link(:class, "next_page").exist?
            BROWSER.link(:class, "next_page").click
          end
        end
      end
    end
  end
end