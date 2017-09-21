###################### Step Definitions When "i entered \"\" and \"\" and \"\" and \"\" and \"\"" #############

And /^i entered "([^"]*)" and "([^"]*)" and "([^"]*)" and "([^"]*)" and "([^"]*)"$/ do |domain, discount, type, deal, product|

  BROWSER.text_field(:id, "corporate_discount_domain").set domain

  BROWSER.text_field(:id, "corporate_discount_discount").set discount

  BROWSER.select_list(:id, "corporate_discount_item_type").select_value(type)

  if type=="deal"
    if deal != ""
      BROWSER.select_list(:id, "corporate_discount_deal_item").select_value(deal)
    end
  end
  if type=="product"
    if product != ""
      BROWSER.select_list(:id, "corporate_discount_product_item").select_value(product)
    end
  end
  discount_label_en = "#{discount} taka extra for #{domain} users"

  BROWSER.text_field(:id,"corporate_discount_discount_label_en").set discount_label_en
  BROWSER.text_field(:id,"corporate_discount_discount_label_bn").set discount_label_en
end

######################## Step Definitions Then "The page shows \"\"" ######################

Then /^The page shows "([^"]*)"$/ do |text|
  if text!= ""
    if BROWSER.contains_text(text) then

      puts text

    end

  end
   if BROWSER.contains_text("Corporate discount was successfully created.")
      puts "created and entered"
      if BROWSER.link(:text, "New corporate discount").exist?
        BROWSER.link(:text, "New corporate discount").click
        puts "Enter New corporate discount"
      end
    end
end

###################### Step Definitions And I enter the following records ####################

And /^I enter the following records$/ do |table|
  # table is a |
  table.hashes.each do |hash|
    @domain = hash["domain"]
    @discount = hash["discount"]
    @type = hash["type"]
    @deal = hash["deal"]
    @product = hash["product"]
    @error = hash["error"]


    When "i entered \"#{@domain}\" and \"#{@discount}\" and \"#{@type}\" and \"#{@deal}\" and \"#{@product}\""

    Then "i submit with \"Create Corporate discount\""       ##sign_up.rb

    Then "The page shows \"#{@error}\""
    puts "=================="
    puts @domain + @discount
    puts "=================="
  end
end

############################### Step Definitions Then i check the meta search option ########################

Then /^i check the meta search option$/ do
  @domain = "banglalion.com"
  @type =  "product"
  puts @domain + @type
  if BROWSER.link(:text,"Cancel").exist?
   BROWSER.link(:text,"Cancel").click
  end
  puts "entered"

  BROWSER.text_field(:id,"search_domain_contains").set @domain

  BROWSER.select_list(:id,"search_item_type_equals").select_value(@type.downcase)
  if BROWSER.button(:value,"Filter").exist?
    puts "clicked"
    BROWSER.button(:value,"Filter").click
  end
  row_value = BROWSER.table(:class=>"list").row_count()
    column_val =  BROWSER.table(:class=>"list").row(:index,2).column_count()
  puts row_value.to_s + "row value + column value" + column_val.to_s
  row_index=2
  column_index = 0
  while column_index<column_val
   if BROWSER.table(:class=>"list").row(:index,1)[column_index].text == "Email"
     @domain_column_index = column_index
     puts @domain_column_index
   end
   if BROWSER.table(:class=>"list").row(:index,1)[column_index].text == "Type"
     @type_column_index = column_index
     puts @type_column_index
   end
   column_index = column_index+1
  end
  while row_index<row_value
    if BROWSER.table(:class=>"list").row(:index,row_index)[@domain_column_index].text == @domain && BROWSER.table(:class=>"list").row(:index,row_index)[@type_column_index].text == @type
      puts "SEARCH SUCCESSFUL"
    end
    row_index = row_index+1
    puts row_index
  end
end