def random_number(length)
  numbers = '0123456789'
  phone = ''
  length.times { phone << numbers[rand(numbers.size)] }
  phone
end

def random_string(length)
  chars = '_.abcdefghjkmnpqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ23456789'
  password = ''
  length.times { password << chars[rand(chars.size)] }
  password

end

def random_string_bangla(length)
  chars = 'ক্বেরত্যুইওপাসদফঘজক্লযক্সচভবন্ম,।/;১২৩৪৫৬৭৮৯০্যক্সচভবণ্মম্লকঝগফডশাক্বেড়টয়ূঈওপ '
  password = ''
  length.times { password << chars[rand(chars.size)] }
  password

end

######################## Step definitions  And  "I enter a date and time with following records" #################

And  /^I enter a date and time with following records$/ do |table|
  table.hashes.each do |hash|
    id = hash["id"]
    value = hash["value"]
    puts id+value
   #BROWSER.select_list(:id, id).clear
   BROWSER.select_list(:id, id).select_value(value)

    end
end

#################### Step Definitions Then I give entry of a new deal #########################

Then /^I give entry of a new deal$/ do
  @merchants = ["1", "2", "3", "4", "5", "6", "7", "8","9","10","11","12","13","14","15","16","17","18"]
  merchant = @merchants[rand(@merchants.length)]
  puts merchant
  BROWSER.select_list(:id, "deal_merchant_id").select_value(merchant)
  title_en = random_string(20)
  BROWSER.text_field(:id,"deal_title").set title_en
  title_bn = random_string_bangla(20)
  BROWSER.text_field(:id,"bangla_deal_title").set title_bn
  BROWSER.text_field(:id,"deal_campaign_name").set "001"
  short_description_en = random_string(40)
  BROWSER.text_field(:id,"deal_description").set short_description_en
  short_description_bn = random_string_bangla(40)
  BROWSER.text_field(:id,"bangla_deal_description").set short_description_bn
  @year = ["2011", "2012", "2013", "2014", "2015", "2016","2017"]
  @month = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"]
  @day = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30"]
  @hour = ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23"]
  @minute = ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59"]
  year_end = @year[rand(@year.length)]
  month_end = @month[rand(@month.length)]
  day_end = @day[rand(@day.length)]
  hour_end =@hour[rand(@hour.length)]
  minute_end =@minute[rand(@minute.length)]
  year_start = BROWSER.select_list(:id,"deal_start_date_1i").value
  while (year_end<=year_start)
    year_end = @year[rand(@year.length)]
  end
#   |deal_start_date_1i    |#{year_start}  |
#       |deal_start_date_2i    |#{month_start} |
#       |deal_start_date_3i    |#{day_start}   |
#       |deal_start_date_4i    |#{hour_start}  |
#       |deal_start_date_5i    |#{minute_start}|
#   |deal_valid_from_1i    |#{year_start}  |
#       |deal_valid_from_2i    |#{month_start} |
#       |deal_valid_from_3i    |#{day_start}   |
#       |deal_valid_from_4i    |#{hour_start}  |
#       |deal_valid_from_5i    |#{minute_start}|
  And  "I enter a date and time with following records", table(%{
       | id                   | value         |
       |deal_end_date_1i      |#{year_end}    |
       |deal_end_date_2i      |#{month_end}   |
       |deal_end_date_3i      |#{day_end}     |
       |deal_end_date_4i      |#{hour_end}    |
       |deal_end_date_5i      |#{minute_end}  |
  })
  And "I enter a date and time with following records", table(%{
       | id                   | value         |
       |deal_valid_to_1i      |#{year_end}    |
       |deal_valid_to_2i      |#{month_end}   |
       |deal_valid_to_3i      |#{day_end}     |
       |deal_valid_to_4i      |#{hour_end}    |
       |deal_valid_to_5i      |#{minute_end}  |
  })
    BROWSER.text_field(:id,"deal_actual_price").set random_number(3)
    BROWSER.text_field(:id,"deal_discounted_price").set random_number(2)
    original_price_label = random_string(10)+" "+random_string(10)+" "+random_string(10)+" "+random_number(3)+"taka"
    BROWSER.text_field(:id,"deal_price_label").set original_price_label
    original_price_label_bangla =  random_string_bangla(10)+" "+random_string_bangla(10)+" "+random_string_bangla(10)+" "+random_number(3)+"taka"
    BROWSER.text_field(:id,"bangla_deal_price_label").set original_price_label_bangla
    BROWSER.select_list(:id,"deal_status").select_value("approved")
    BROWSER.file_field(:id,"deal_pictures_attributes_index_to_replace_with_js_data").set("F:\\Working\\deal pics\\tiny_logo.gif")
    BROWSER.button(:id,"deal_submit").click
end