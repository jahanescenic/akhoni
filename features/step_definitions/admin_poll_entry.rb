$case = 0
$no_of_cases = 2

def random_string(length)
  chars = '_.abcdefghjkmnpqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ23456789'
  name = ''
  length.times { name << chars[rand(chars.size)] }
  name

end

When /^I give text field entry of "([^\"]*)" in "([^\"]*)"$/ do |entry_text, id|
  BROWSER.text_field(:id, id).set entry_text
end

Then /^I activate-deactivate with "([^\"]*)"$/ do |active|
  if active=="checked"
    BROWSER.checkbox(:id, "poll_is_active").set
  end
end

Then /^I enter following poll data$/ do |table|
  # table is a |                          | random_special|                          |
  table.hashes.each do |hash|
    question = hash["question"]
    description = hash["description"]
    active = hash["active"]
    options = hash["options"]
    question_entry = random_string(10) + " " + random_string(10) + " " + random_string(10) + " " + random_string(10)
    description_entry = random_string(100)
    options_entry = random_string(20)
    $case = $case + 1
    When "I give text field entry of \"#{question_entry}\" in \"#{question}\""
    Then "I give text field entry of \"#{description_entry}\" in \"#{description}\""
    Then "I activate-deactivate with \"#{active}\""
    Then "I give text field entry of \"#{options_entry}\" in \"#{options}\""
    end_d = BROWSER.select_list(:id, "poll_end_date_1i").value
    end_date = end_d.to_i
    end_date = end_date + 1
    puts end_date
    BROWSER.select_list(:id, "poll_end_date_1i").select_value(end_date)
    Then "I \"poll_submit\" the search"
    if BROWSER.table(:class, "list").exist?
      And "I want to know the column number of \"Question\" of \"list\" from index number \"1\""
      ques_col = $column_number
      row_value = BROWSER.table(:class, "list").row_count()
      BROWSER.table(:class, "list").rows.each_with_index do |row, index|
        if index > 1 && index < (row_value-1)
          if BROWSER.table(:class, "list").row(:index, index)[ques_col].text.include? question_entry
            $final_index = index
            puts "Final Index - #{$final_index}"
          end
        end
      end
      And "I want to know the column number of \"Active?\" of \"list\" from index number \"1\""
      active_col = $column_number
      if active == "checked"
        if BROWSER.table(:class, "list").row(:index, $final_index)[active_col].text.include? "Yes"
          puts "It's a active poll and showing right"
        else
          puts "It's a active poll and showing wrong"
        end
      else
        if BROWSER.table(:class, "list").row(:index, $final_index)[active_col].text.include? "No"
          puts "It's a de-active poll and showing right"
        else
          puts "It's a de-active poll and showing wrong"
        end
      end
    end
    if $case < $no_of_cases
      When "I go for a \"New Poll\""
    end
  end
end