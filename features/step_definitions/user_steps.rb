Given(/^I have one user with email "(.*?)" and password "(.*?)"$/) do |email, password|
  user = FactoryGirl.create(:user, email: email, password: password)
end

Given(/^I have one confirmed user with email "(.*?)" and password "(.*?)"$/) do |email, password|
  user = FactoryGirl.create(:user, email: email, password: password, confirmation_token: nil, confirmed_at: DateTime.now)
end

Given(/^I have signed in with valid credential$/) do
  email = "test@chanintr.com"
  password = "Secret01"
  step("I have one confirmed user with email \"#{email}\" and password \"#{password}\"")
	step("I visit \"/users/sign_in\"")
  step("I fill in \"Email\" with \"#{email}\"")
	step("I fill in \"Password\" with \"#{password}\"")
	step("I click button \"Sign In\"")
  step("I should be redirected to \"/users/edit\"")
  step("I should see \"Signed in successfully.\"")
end