Feature:
  As a user I want to refer a friend and get referral credit

Scenario Outline: REFER YOUR FRIEND
  When i go to url "<url>"
  And I go to "http://alpha.akhoni.com/referrals/history" if i don't need to "Sign In" with "user@akhoni.com" and "secret"
  Then I store my referral credit
  Then I go to "http://alpha.akhoni.com/referrals"
  And I store my referral link

Examples:
  | url  |
  | http://alpha.akhoni.com/referrals/history |
