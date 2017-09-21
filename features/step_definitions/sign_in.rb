########################### Step Definitions When "i log in with \"#{@user}\" and \"#{pass}\"" ###################

When /^i log in with "([^"]*)" and "([^"]*)"$/ do |user,pass|

     BROWSER.text_field(:id, "user_login").set(user)

     BROWSER.text_field(:id, "user_password").set(pass)
end

######################### Step Definitions And "The user is \"#{roles}\"" ########################################

And /^The user is "([^"]*)"$/ do |role|
     if role == "Admin"
       BROWSER.goto "alpha.akhoni.com/manage"
       if BROWSER.text.include? "Welcome to admin panel"
         puts "ADMIN"
       end
     elsif role == "Report"
      BROWSER.goto "http://alpha.akhoni.com/merchant/report"
       if BROWSER.link(:text,"REPORT").exist?
         puts "MERCHANT"
       end
     end
end

####################### Step Definitions Given The following user records ##########################

Given /^The following user records$/ do |table|

  table.hashes.each do |hash|

    at_d = hash["username"]
    if at_d.include? ","
      at_dot = at_d.split(",")
      @host = ["yahoo", "gmail", "baz", "dolor", "lorem", "ipsum"]
      @tld  = ["com", "org", "net", "us", "tl"]
      user_email = random_string(10)

      host = @host[rand(@host.length)]
      tld  = @tld[rand(@tld.length)]
      if(at_dot[0]!= nil && at_dot[1]!=nil)
        @user = user_email+at_dot[0]+host+at_dot[1]+tld
      else
        @user = user_email.clone
      end
    else
       @user = at_d.clone
    end
    puts @user

    pass = hash["password"]

    messeges =  hash["messeges"]

    roles = hash["roles"]

    When "i log in with \"#{@user}\" and \"#{pass}\""

    And "i submit with \"Sign In\""                         ##sign_up.rb

    Then "The page says \"#{messeges}\""                    ##sign_up.rb

    And "The user is \"#{roles}\""

    Then "I click on \"Sign In\""
  end

end
