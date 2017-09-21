$case=0
$no_of_test_case = 4


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

def random_special_chars(length)
  chars = '<>?:{}!@#$%^&*()=_'
  text = ''
  length.times { text << chars[rand(chars.size)] }
  text
end

############################### Step Definitions And "I check the notice" ###########################################

And /^I check the notice$/ do
  if BROWSER.contains_text("Press release was saved successfully") or BROWSER.contains_text("Press release was updated successfully")
    puts "SUCCESSFULLY UPDATED OR CREATED"
  end
end

############################## Step Definitions Then "I check the press release portion with \"\" and \"\" and \"\"" #############

Then /^I check the press release portion with "([^\"]*)" and "([^\"]*)" and "([^\"]*)"$/ do |header, description, link|

  case $case
    when 1 :
      puts "ENTER"
      if BROWSER.contains_text(description)
        puts description
        puts "okk"
      end
    when 2 :
      if BROWSER.contains_text(header)
       puts header
      end


    when 3 :
      if BROWSER.contains_text(description) && BROWSER.contains_text(header)
        puts "Title and Description is OK - Published"
      end
  end
end

############################### Step Definitions Then "i go to \"\" option" #################################

Then /^i go to "([^\"]*)" option$/ do |edit|


  if BROWSER.link(:text, edit).exist?
    BROWSER.link(:text, edit).click
  end

end

############################## Step Definitions When "i enter \"\" and \"" and \"\"" #################

When /^i enter "([^\"]*)" and "([^\"]*)" and "([^\"]*)"$/ do |header, description, link|
  BROWSER.text_field(:id, "press_title").set header

  BROWSER.text_field(:id, "press_description").set description

  BROWSER.text_field(:id, "press_url").set link

  BROWSER.file_field(:id, "press_logo").set("D:\\deal pics\\airport-parking-(left)_monkey_30x15.jpg")

  sleep 3
end

######################## Step Definitions Then I enter following data ###########################

Then /^I enter following data$/ do |table|
  # table is a |                          | random_special|                          |                    |
  table.hashes.each do |hash|
    header = hash["title_press"]
    description = hash["description"]
    url = hash["url"]

    if header== "random_special"
      header = random_special_chars(15)
    elsif header == "random"
      header = random_string(20)
    end
    if description== "random_special"
      description = random_special_chars(30)
    elsif description == "random"
      description = random_string(30)
    end
    @host = ["yahoo", "gmail", "baz", "dolor", "lorem", "ipsum"]
    if url=="valid"
      url = "http://www." + random_string(10) + @host[rand(@host.length)] + "/"+ random_string(5) + "." + "php"
      puts @url
    end


    When "i enter \"#{header}\" and \"#{description}\" and \"#{url}\""

    Then "I click to submit on \"press_submit\""                                                     ## feature_your_business.rb

    $case = $case++1

    And "I check the notice"

    Then "I go to \"http://alpha.akhoni.com/Press\""                                                  ##my_steps.rb

    Then "I check the press release portion with \"#{header}\" and \"#{description}\" and \"#{url}\""

    Then "I go to \"http://alpha.akhoni.com/manage/presses\""                                         ##my_steps.rb

    Then "i go to \"Edit\" option"
  end

end

