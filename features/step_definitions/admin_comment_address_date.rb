def random_string(length)
  chars = '~!@#$%^&*()_+{}|:"<>?/*+-_.abcdefghjkmnpqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ23456789'
  name = ''
  length.times { name << chars[rand(chars.size)] }
  name

end

####################### Step definitions And  I click on the "" link #####################

When /^I click on the "([^\"]*)" link$/ do |arg1|
  if BROWSER.link(:text, arg1).exist
    BROWSER.link(:text, arg1).click
    if BROWSER.text_field(:id, "comment_value").exist
      @comment = random_string(20)
      BROWSER.text_field(:id, "comment_value").set @comment
      puts "Comment Entered"
    end
    if BROWSER.text_field(:id, "address_value").exist
      @address = random_string(30)
      BROWSER.text_field(:id, "address_value").set @address
      puts "Address Entered"
    end
    Then "I want to enter a delivery date"
    if BROWSER.button(:text, "Save").exist?
      BROWSER.button(:text, "Save").click
    end
    @comment_address = @comment+@address
    puts @comment_address
    @column_val = BROWSER.table(:class, "list").row(:index, 2).column_count()
    puts @column_val
    $col=1
    while $col<=@column_val do
      if BROWSER.table(:class, "list").row(:index, 2)[$col].text == "Comment"
        $comment_col = $col
      end
      $col+=1
    end
    @com = 0
    $page=0
    while ($page!=1)
      BROWSER.table(:class, "list").rows.each_with_index do |row, index|
        if index>1
          if BROWSER.table(:class, "list").row(:index, index)[@column_val].text == @comment_address
            @com = 1
            @page = 1
          end

        end
        if @com==1
          break
        end
      end
      if @com==0
        if BROWSER.link(:class, "next_page").exist?
          BROWSER.link(:class, "next_page").click
        end
      end
      if @comment_col.to_s == @comment_address
        puts "Test Successful"
      end
    end
  end
  end
