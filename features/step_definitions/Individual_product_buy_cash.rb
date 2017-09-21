$product_counter = 0

############################ Step Definitions Then "I am in \"Your Purchase\" page and change the quantity of order to \"2\"" ############

Then (/^I am in "([^"]+)" page and change the quantity of order to "([^"]+)"$/) do |page_title, quantity|
  if (BROWSER.contains_text(page_title)) then
    if  BROWSER.text_field(:id, "order_quantity").exist?
      BROWSER.text_field(:id, "order_quantity").set quantity
    end
    BROWSER.checkbox(:id, "agree").set
    BROWSER.button(:id, "order_submit").click
    puts "YOUR PURCHASE OK" if BROWSER.contains_text("Your Order Details")

  end
end

######################## Step Definitions Then "I go for buy" ############################

Then (/^I go for buy$/) do
  $product_counter-=1
  if BROWSER.link(:class, "multiple-product").exist?
    @live_product_url = BROWSER.link(:class, "multiple-product").href
    BROWSER.link(:class, "multiple-product").click
  end

  if  BROWSER.link(:text, "Sold Out").exist?
    puts "THIS PRODUCT IS SOLD OUT"
    if $product_counter>0
      if (@live_product_url!='')
        url=@live_product_url.split("/")
        next_url=''
        url.each do |u|
          if u.to_i==0
            next_url+= u.to_s+"/"
          else
            product_id=u.to_i+1
            next_url+=product_id.to_s
          end
        end
        BROWSER.goto next_url
        @live_product_url= next_url
        Then "I go for buy"
      end
    else
      puts "ALL PRODUCTS ARE SOLD OUT"
    end
  elsif  BROWSER.link(:class, "buy_now_btn").exist?
    puts "BUY NOW BUTTON FOUND"
    BROWSER.link(:class, "buy_now_btn").click
    if BROWSER.contains_text "Please select size"
      puts "Please select size"
    end
    if BROWSER.div(:class, "size_box_row").exist?
      BROWSER.button(:xpath, "//ul[@class='product-size']/li[@class='available']").click()
      BROWSER.link(:class, "buy_now_btn").click
    end

    Then "I am in \"Your Purchase\" page and change the quantity of order to \"2\""
  end
end

###################### Step Definitions Then I go to a product's details #########################

Then /^I go to a product's details$/ do

  if BROWSER.div(:id, "page-wrap").divs.each do |d|
    if d.class_name=="product_image_hover_wrapper"
      puts $product_counter
      $product_counter=$product_counter+1
       Then "I go for buy"
    end
  end
  end
  #Then "I go for buy"
end