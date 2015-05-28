Given(/^I visit "(.*?)"$/) do |page_url|
  visit(page_url)
end

When(/^I visit "(.*?)" via the API$/) do |page_url|
  page.driver.post(page_url) 
  page.driver.status_code.should eql 200
end

When(/^I delete "(.*?)" via the API$/) do |page_url|
  page.driver.delete(page_url) 
  page.driver.status_code.should eql 302
end

When(/^I fill in "(.*?)" with "(.*?)"$/) do |fieldname, value|
  fill_in( fieldname , :with => value)
end

When(/^I click link "(.*?)"$/) do |link|
  click_link(link)
end

Then(/^I should see "(.*?)"$/) do |content|
  expect(page).to have_content(content)
end

Then(/^I should be redirected to "(.*?)"$/) do |expected_uri|
  expect(page.current_path).to eq expected_uri
end

When(/^I check in checkbox "(.*?)"$/) do |checkbox|
  check(checkbox)
end

When(/^I click button "(.*?)"$/) do |button_name|
  click_button(button_name)
end

When(/^I click "(.*?)"$/) do |value|
  click(value)
end

When(/^I submit the "(.*?)" form$/) do |form_id|
   element = find_by_id(form_id)
   Capybara::RackTest::Form.new(page.driver, element.native).submit :name => nil
end



