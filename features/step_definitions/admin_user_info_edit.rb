def random_string(length)
  chars = '_.abcdefghjkmnpqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ23456789'
  password = ''
  length.times { password << chars[rand(chars.size)] }
  password

end

def random_number(length)
  numbers = '0123456789'
  phone = ''
  length.times { phone << numbers[rand(numbers.size)] }
  phone
end

######################### Step Definitions Then I search the user and edit the user ######################

Then /^I search the user and edit the user$/ do
#  if BROWSER.text_field(:id, "search_email_or_firstname_or_lastname_or_phone_contains").exist?
#    BROWSER.text_field(:id, "search_email_or_firstname_or_lastname_or_phone_contains").set $user
#  end
#  Then "I \"search_submit\" the search"                                                   ## admin_order_filter.rb
  Then "I go to \"http://alpha.akhoni.com/manage/users/verify\""                          ## my_steps.rb
  if BROWSER.table(:class, "list").exist?
    And "I want to know the column number of \"ID\" of \"list\" from index number \"2\""  ## admin_order_filter.rb
    $id_col = $column_number
    id = BROWSER.table(:class, "list").row(:index, 3)[$id_col].text
    gender_id_m = "gender_#{id}_M"
    gender_id_f = "gender_#{id}_F"
    is_subscribed_y = "is_subscribed_#{id}_1"
    is_subscribed_n = "is_subscribed_#{id}_0"
    is_verified_y = "is_verified_#{id}_1"
    is_verified_n = "is_verified_#{id}_0"

    if BROWSER.radio(:id, gender_id_m).set?
      BROWSER.radio(:id, gender_id_f).set
      gender_step=gender_id_f
      puts gender_step
    elsif BROWSER.radio(:id, gender_id_f).set?
      BROWSER.radio(:id, gender_id_m).set
      gender_step = gender_id_m
      puts gender_step
    else
      BROWSER.radio(:id, gender_id_m).set
      gender_step = gender_id_m
      puts gender_step
    end
    if BROWSER.radio(:id, is_subscribed_y).set?
      BROWSER.radio(:id, is_subscribed_n).set
      subscribed_step = is_subscribed_n
      puts subscribed_step
    elsif BROWSER.radio(:id, is_subscribed_n).set?
      BROWSER.radio(:id, is_subscribed_y).set
      subscribed_step = is_subscribed_y
      puts subscribed_step
    else
      BROWSER.radio(:id, is_subscribed_y).set
      subscribed_step = is_subscribed_y
      puts subscribed_step
    end
    if BROWSER.radio(:id, is_verified_y).set?
      BROWSER.radio(:id, is_verified_n).set
      verify_step = is_verified_n
      puts verify_step
    elsif BROWSER.radio(:id, is_verified_n).set?
      BROWSER.radio(:id, is_verified_y).set
      verify_step = is_verified_n
      puts verify_step
    else
      BROWSER.radio(:id, is_verified_y).set
      verify_step = is_verified_n
      puts verify_step
    end
    BROWSER.button(:value, "Update").click
    if BROWSER.radio(:id, gender_id_m).set?
        if gender_id_m == gender_step
          puts gender_step
        end
    elsif BROWSER.radio(:id, gender_id_f).set?
      if gender_id_f == gender_step
        puts gender_step
      end
    end
    if BROWSER.radio(:id, is_subscribed_y).set?
        if is_subscribed_y == subscribed_step
          puts subscribed_step
        end
    elsif BROWSER.radio(:id, is_subscribed_n).set?
      if is_subscribed_n == subscribed_step
        puts subscribed_step
      end
    end
    if BROWSER.radio(:id, is_verified_y).set?
     if is_verified_y == verify_step
          puts verify_step
     end
    elsif BROWSER.radio(:id, is_verified_n).set?
     if is_verified_n == verify_step
          puts verify_step
     end
    end

  end
end

