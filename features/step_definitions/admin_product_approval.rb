When /^I approve a product and check it on product list when it is "([^\"]*)"$/ do |option|
  And "I want to know the column number of \"Status\" of \"list\" from index number \"1\""
  $status_col = $column_number
  BROWSER.table(:class, "list").rows.each_with_index do |row, index|
    if index>1
      $status_col = $status_col.to_i
      if BROWSER.table(:class, "list")[index][$status_col].text.include? "pending"
        $product_index = index
        break
      end
    end
  end
  And "I want to know the column number of \"Name\" of \"list\" from index number \"1\""
  $name_col = $column_number
  product_link = BROWSER.table(:class, "list").row(:index, $product_index)[$name_col].text
  BROWSER.link(:text, product_link).click
  BROWSER.select_list(:id, "product_status").select_value("approved")
  if option == "featured"
    BROWSER.checkbox(:id,"product_is_featured").set
  end
  Then "I \"product_submit\" the search"
  Then "I go to \"alpha.akhoni.com/dhaka/products\""
  puts product_link
  if BROWSER.text.include? product_link
    puts "FOUND THE PRODUCT IN THE LIST"
  else
    puts "PRODUCT IS STILL UNAPPROVED OR THEIR IS UNEXPECTED ERROR"
  end
  if option == "not featured"
    BROWSER.goto "alpha.akhoni.com"
    tds = 0
    no_of_tds = BROWSER.table(:id, "featured_products").tds.length
    while tds<no_of_tds
      if BROWSER.table(:id, "featured_products").td(:index, tds).div(:class, "show-product-details_link").text == product_link
        puts "PRODUCT IS NOT SHOWING - RIGHT"
      end
      tds = tds+1
    end
  end
  if option == "featured"
    BROWSER.goto "alpha.akhoni.com"
    tds = 0
    no_of_tds = BROWSER.table(:id, "featured_products").tds.length
    while tds<no_of_tds
      if BROWSER.table(:id, "featured_products").td(:index, tds).div(:class, "show-product-details_link").text == product_link
        puts "PRODUCT IS SHOWING - RIGHT"
      end
      tds = tds+1
    end
  end
end