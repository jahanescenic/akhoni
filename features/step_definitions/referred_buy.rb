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

When /^I need to "([^\"]*)"$/ do |arg1|
  if BROWSER.link(:text, "Sign Out").exist?
    BROWSER.link(:text, "Sign Out").click
  end
  if BROWSER.link(:text,arg1).exist?
    BROWSER.link(:text,arg1).click
  end
end