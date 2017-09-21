############################# Step Definitions And  I click on deal specific report #########################

When /^I click on deal specific report$/ do
  if BROWSER.link(:xpath, "//a[@href='/manage/deals/stat_report']").exist?
    puts "ENTERED ON DEAL SPECIFIC STATISTICAL REPORT"
    BROWSER.link(:xpath, "//a[@href='/manage/deals/stat_report']").click
  else
    puts "DOESN'T ENTERED ON DEAL SPECIFIC STATISTICAL REPORT"
  end
end

############################ Step Definitions And  I enter a date and time and press generate #################

When /^I enter a date and time and press generate$/ do
  #####Start Date############################################################################

  @year = ["2007", "2008", "2009", "2010", "2011", "2012", "2013", "2014", "2015", "2016","2017"]
  year_start = @year[rand(@year.length)]
  #BROWSER.select_list(:id, "_start_date_1i").clear
  BROWSER.select_list(:id, "_start_date_1i").select_value(year_start)
  puts year_start
  @month = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"]
  month = @month[rand(@month.length)]
  #BROWSER.select_list(:id, "_start_date_2i").clear
  BROWSER.select_list(:id, "_start_date_2i").select_value(month)
  puts month
  @day = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30"]
  day = @day[rand(@day.length)]
  #BROWSER.select_list(:id, "_start_date_3i").clear
  BROWSER.select_list(:id, "_start_date_3i").select_value(day)
  puts day
  @hour = ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23"]
  hour = @hour[rand(@hour.length)]
  #BROWSER.select_list(:id, "_start_date_4i").clear
  BROWSER.select_list(:id, "_start_date_4i").select_value(hour)
  puts hour
  @minute = ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59"]
  minute = @minute[rand(@minute.length)]
  #BROWSER.select_list(:id, "_start_date_5i").clear
  BROWSER.select_list(:id, "_start_date_5i").select_value(minute)
  puts minute
  ######End date############################################################################
  @year = ["2007", "2008", "2009", "2010", "2011", "2012", "2013", "2014", "2015", "2016","2017"]
  year_end = @year[rand(@year.length)]
  #BROWSER.select_list(:id, "_end_date_1i").clear
  BROWSER.select_list(:id, "_end_date_1i").select_value(year_end)
  puts year_end
  @month = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"]
  month = @month[rand(@month.length)]
  #BROWSER.select_list(:id, "_end_date_2i").clear
  BROWSER.select_list(:id, "_end_date_2i").select_value(month)
  puts month
  @day = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30"]
  day = @day[rand(@day.length)]
  #BROWSER.select_list(:id, "_end_date_3i").clear
  BROWSER.select_list(:id, "_end_date_3i").select_value(day)
  puts day
  @hour = ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23"]
  hour = @hour[rand(@hour.length)]
  #BROWSER.select_list(:id, "_end_date_4i").clear
  BROWSER.select_list(:id, "_end_date_4i").select_value(hour)
  puts hour
  @minute = ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59"]
  minute = @minute[rand(@minute.length)]
  #BROWSER.select_list(:id, "_end_date_5i").clear
  BROWSER.select_list(:id, "_end_date_5i").select_value(minute)
  puts minute
  if year_end<=year_start
    When "I enter a date and time and press generate"
  else
  if BROWSER.button(:value, "Generate").exist?
    BROWSER.button(:value, "Generate").click
    if BROWSER.table(:class,"list").exist?
      puts "entered"
      @no_of_records = 0
      @no_of_records=BROWSER.table(:class,"list").rows.length
      puts "**************#{@no_of_records}"
    end
  end
    end
end