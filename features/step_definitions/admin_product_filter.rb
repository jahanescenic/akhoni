
########################## Step Definitions Then "I give entry of \"\" and submit the form" ##################

Then /^I give entry of "([^\"]*)" and submit the form$/ do |$product_name|
  BROWSER.text_field(:id, "search_name_contains").set product_name
  if BROWSER.button(:id, "search_submit").exist?
    BROWSER.button(:id, "search_submit").click
  end
  @product_result=1
  if BROWSER.table(:class, "list").exist?
    BROWSER.table(:class, "list").rows.each_with_index do |row, index|
      if index==0
        next
      end
      @index = index
      row.cells.each do |cell|
        if cell.text == product_name
          puts product_name + " found"
          @product_result = @product_result+1
        end
      end
    end
    if @product_result == @index-1
      puts "Filtering of product is OK"
    end
  end
end

##################################### Step Definitions And I select merchant name from the list of options #####################

When /^I select merchant name from the list of options$/ do
  $no_of_rows =  BROWSER.table(:class,"list").row_count() if BROWSER.table(:class,"list").exist?
  @merchants = ["14", "6", "5", "11", "8", "3", "10", "13","16","18","15","19","20"]
  merchant = @merchants[rand(@merchants.length)]
  puts "*****************" + merchant + "***************************"

  BROWSER.select_list(:id, "search_merchant_id_equals").select_value(merchant)
  if BROWSER.button(:id, "search_submit").exist?
    BROWSER.button(:id, "search_submit").click
  end
  @merchant_result = 1
  if BROWSER.table(:class, "list").exist?
    BROWSER.table(:class, "list").rows.each_with_index do |row, index|
      if index == 0
        next
      end
      @index = index
      row.cells.each do |cell|
        if cell.text == merchant
          puts cell.text
          @merchant_result = @merchant_result+1
        end
      end
    end
    if @merchant_result== @index-1
      puts "Filtering of merchant is OK"
      product_name = BROWSER.table(:class, "list").row(:index, 3)[2].text
      puts product_name + " going for next step"
      Then "I give entry of \"#{product_name}\" and submit the form"
    end
  end
end

##################### Step Definitions And I press "" button and check the functionality ###########################

When /^I press "([^\"]*)" button and check the functionality$/ do |arg1|
  if BROWSER.button(:value,arg1).exist?
   BROWSER.button(:value,arg1).click
  end
  @no_of_rows_after_reset = BROWSER.table(:class,"list").row_count() if BROWSER.table(:class,"list").exist?
  if @no_of_rows_after_reset==$no_of_rows
    puts "Reset button is OK"
  end
end