def random_string(length)
  chars = '_.abcdefghjkmnpqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ23456789'
  password = ''
  length.times { password << chars[rand(chars.size)] }
  password

end

def random_number_product_entry(length)
  numbers = '23456789'
  digit = ''
  length.times { digit << numbers[rand(numbers.size)] }
  digit
end

########################### Step Definitions Then "I check \"\" in \"\" in \"\" in index \"\"" ############################

Then /^I check "([^"]*)" in "([^"]*)" in "([^"]*)" in index "([^"]*)"$/ do |checking_text, table_class, column_number, index|
  column_number = column_number.to_i
  index = index.to_i
  puts BROWSER.table(:class, table_class).row(:index, 6)[column_number].text
  if BROWSER.table(:class, table_class).row(:index, index)[column_number].text.include? checking_text
    puts "The checking content is found - #{checking_text}"
  else
    puts "NOTHING SHOWN"
  end

end


############################# Step Definitions Then I give product entry ##########################

Then /^I give product entry$/ do
  $product_name = random_string(15)
  BROWSER.text_field(:id, "product_name").set $product_name
  description = random_string(30)
  BROWSER.text_field(:id, "product_description").set description
  end_y = BROWSER.select_list(:id, "product_end_date_1i").value
  end_year = end_y.to_i
  end_year = end_year+1
  BROWSER.select_list(:id, "product_end_date_1i").select_value(end_year)
  end_valid_y = BROWSER.select_list(:id, "product_end_date_1i").value
  end_valid_year = end_valid_y.to_i
  end_valid_year = end_valid_year+1
  BROWSER.select_list(:id, "product_valid_to_1i").select_value(end_valid_year)
  quantity = random_number_product_entry(1)
  puts quantity
  BROWSER.text_field(:id, "product_quantity").set quantity
  actual_price = random_number_product_entry(1)+"00"
  actual_price = actual_price.to_s
  puts "Actual Price - #{actual_price}"
  while (actual_price.to_i <= 400)
    actual_price =  random_number_product_entry(1)+"00"
    puts "Actual Price - #{actual_price}"
  end
  dis_price = random_number_product_entry(1)+"00"
  dis_price = dis_price.to_s
  puts "Discount Price - #{dis_price}"
  while dis_price.to_i >= actual_price.to_i
    dis_price = random_number_product_entry(1)+"00"
    dis_price = dis_price.to_s
    puts "Discount Price - #{dis_price}"
  end
  BROWSER.text_field(:id, "product_actual_price").set actual_price

  BROWSER.text_field(:id, "product_discounted_price").set dis_price

  #BROWSER.file_field(:id, "product_pictures_attributes_index_to_replace_with_js_data").set("E:\\pics\\alone-400151.jpeg")
  Then "I \"product_submit\" the search"
  $page=0
  while ($page!=1)
    And "I want to know the column number of \"Name\" of \"list\" from index number \"1\"" ##admin_order_filter.rb
    $name_col= $column_number
    Then "I check \"#{$product_name}\" in \"list\" in \"#{$name_col}\"" ##admin_order_filter.rb
    BROWSER.table(:class, "list").rows.each_with_index do |row, index|
      if index>2
        if BROWSER.table(:class, "list").row(:index, index)[$name_col].text.include? $product_name
          $product_index = index
          puts "product_index - #{$product_index-1}"
        end
      end
    end
    Then "I go to \"next_page\" if exist"
  end

  And "I want to know the column number of \"Quantity\" of \"list\" from index number \"1\"" ##admin_order_filter.rb
  $quantity_col= $column_number
  Then "I check \"#{quantity}\" in \"list\" in \"#{$quantity_col}\" in index \"#{$product_index}\"" ##admin_order_filter.rb

  And "I want to know the column number of \"A. Price\" of \"list\" from index number \"1\""       ##admin_order_filter.rb
  $a_price_col= $column_number
  Then "I check \"#{actual_price}\" in \"list\" in \"#{$a_price_col}\" in index \"#{$product_index}\""                          ##admin_order_filter.rb

  And "I want to know the column number of \"D. Price\" of \"list\" from index number \"1\""       ##admin_order_filter.rb
  $d_price_col= $column_number
  Then "I check \"#{dis_price}\" in \"list\" in \"#{$d_price_col}\" in index \"#{$product_index}\""                          ##admin_order_filter.rb
end

############################### Step Definitions Then /^I will look for a pending product and shouldn't find it on product page as it is not approved ###########

Then /^I will look for a pending product and shouldn't find it on product page as it is not approved$/ do
 #$product_name = ".k2VT8MgwSEWcC4"
 if BROWSER.text.include? $product_name
   puts "FOUND THE PRODUCT IN THE LIST"
 else
   puts "UNAPPROVED PRODUCT IS NOT FOUND"
 end

end