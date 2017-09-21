
############################ Step Definitions And  I go to "http://alpha.akhoni.com/manage" if i don't need to "Sign In" with "admin_user@akhoni.com" and "secret" #############

When /^I go to "([^\"]*)" if i don't need to "([^\"]*)" with "([^\"]*)" and "([^\"]*)"$/ do |arg1, arg2, arg3, arg4|

   BROWSER.goto arg1

  if BROWSER.text.include? "Welcome"
   BROWSER.goto "alpha.akhoni.com/users/sign_out"
 end

  if BROWSER.link(:text,arg2).exist?
      BROWSER.link(:text,arg2).click
      BROWSER.text_field(:name,"user[login]").set arg3
      BROWSER.text_field(:name,"user[password]").set arg4
      BROWSER.button(:id,"user_submit").click
   end
   BROWSER.goto arg1
end

################ Step Definitions And  I click on "ORDER" and select "list" ##############################

When /^I click on "([^\"]*)" and select "([^\"]*)"$/ do |arg1, arg2|
  if BROWSER.link(:text,arg1).exist?
    BROWSER.link(:text,arg1).click
  end

end

######################### Step Definitions And I choose a order from the "" and check whether it is paid or not ##################

When /^I choose a order from the "([^\"]*)" and check whether it is paid or not$/ do |arg1|
    Then "I \"Reset\" the page"
    row_value = BROWSER.table(:class,arg1).row_count()
    column_val =  BROWSER.table(:class,arg1).row(:index,1).column_count()
    #puts column_val
    #puts row_value
    $col=0
    while $col<column_val do
      if BROWSER.table(:class,arg1).row(:index,1)[$col].text == "Status"
        $status_col = $col
      end
      $col+=1
    end
    $confirm = 0
    $page=0
    while($page!=1)
    BROWSER.table(:class,arg1).rows.each_with_index do |row,index|

      if index > 1 && index < row_value-1
        if BROWSER.table(:class,arg1).row(:index,index)[$status_col].text == ""

           if BROWSER.table(:class,arg1).row(:index,index).link(:text,"Confirmed").exist?
           BROWSER.table(:class,arg1).row(:index,index).link(:text,"Confirmed").click
           if BROWSER.div(:id,"notice").exist?
             if BROWSER.div(:id,"notice").text=="Error: Validation failed: Quantity must be between 1 to 1"
               BROWSER.link(:class,"next_page").click
             elsif  BROWSER.div(:id,"notice").text=="Error: Validation failed: Quantity - Already you have exceed the coupon limit for this deal"
               BROWSER.link(:class,"next_page").click
             else
              BROWSER.table(:class,arg1).row(:index,index).link(:text,"Delivered").click
              puts index
              puts "Confirmed successfully"
              And "I want to know the column number of \"Booking Code\" of \"list\" from index number \"1\""
              $booking_code_col = $column_number
              @booking_code = BROWSER.table(:class,arg1).row(:index,index)[$booking_code_col].text
              puts @booking_code
              Then "I fill the booking code field with \"#{@booking_code}\" and check the coupon"      ## my_steps.rb
             # Then "I want to enter a comment on \"#{@index}\""                                        ## admin_delivery_schedule.rb
              $confirm = 1
              $page = 1
             end
           end
         end
        end

        #puts ind
      end
     if $confirm==1
       break
     end
    end
    if $confirm==0
        if BROWSER.link(:class,"next_page").exist?
              BROWSER.link(:class,"next_page").click
       end
    end
    end



end