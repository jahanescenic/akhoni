$referral_credit= 0
$referral_link = ""

########################## Step Definitions  Then I store my referral credit ##########################

Then /^I store my referral credit$/ do
  referral_taka = BROWSER.table(:class,"list").row(:index,1)[2].text
  referral_credit = referral_taka.split(" ")
  $referral_credit = referral_credit[1].to_i
  puts $referral_credit
end

######################## Step Definitions And I store my referral link #################################

When /^I store my referral link$/ do
 BROWSER.goto "alpha.akhoni.com/referrals"
  $referral_link = BROWSER.text_field(:id,"referral_link").value
  puts $referral_link
end
