def random_string(length)
        chars = '_.abcdefghjkmnpqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ23456789'
        password = ''
        length.times { password << chars[rand(chars.size)] }
        password

 end


######################## Step Definitions of Then "I want to enter a delivery date" #############################


Then /^I want to enter a delivery date$/ do
  @year = ["2006", "2007", "2008", "2009", "2010", "2011", "2012", "2013", "2014", "2015", "2016"]
  year_start = @year[rand(@year.length)]
  BROWSER.select_list(:id, "order_delivery_date_1i").clearSelection
  BROWSER.select_list(:id, "order_delivery_date_1i").set(year_start)
  puts year_start
  @month = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
  month = @month[rand(@month.length)]
  BROWSER.select_list(:id, "order_delivery_date_2i").clearSelection
  BROWSER.select_list(:id, "order_delivery_date_2i").set(month)
  puts month
  @day = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30"]
  day = @day[rand(@day.length)]
  BROWSER.select_list(:id, "order_delivery_date_3i").clearSelection
  BROWSER.select_list(:id, "order_delivery_date_3i").set(day)
  puts day
end
######################## Step Definitions of Then  /^I want to enter a comment on "" $/ #############################

Then /^I want to enter a comment on "([^\"]*)"$/ do |index|
  puts index
  if BROWSER.table(:class,"list").row(:index,index).link(:text, "Info").exist?
    BROWSER.table(:class,"list").row(:index,index).link(:text, "Info").click
    if BROWSER.div(:id, "dialog_comment").exist?
      if BROWSER.text_field(:id, "comment_value").exist?
        comment = random_string(10)
        BROWSER.text_field(:id, "comment_value").set(comment)
      end
      Then "I want to enter a delivery date"
      if BROWSER.button(:text,"Save").exist?
        BROWSER.button(:text,"Save").click
      end
      order_no =  BROWSER.table(:class,"list").row(:index,index)[1].text
      puts order_no
      booking_code = BROWSER.table(:class,"list").row(:index,index)[2].text
      puts booking_code
      comment_class = "comment"+order_no.to_s+"_text"
      puts comment_class
      com_cls = BROWSER.div(:class,"comment884_text").value
      puts com_cls
    end
  end
end