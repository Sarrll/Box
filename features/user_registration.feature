Feature: User registration
  In order to ensure that user registration are working collectly
	
	Scenario: Accessing user registration page (Already Logged In)
	  Given I have signed in with valid credential
	  When I visit "sign_up"
		Then I should be redirected to "/users/edit"
	  And I should see "You are already signed in."
	
	Scenario: User registration with existing email address
		Given I have one user with email "test@chanintr.com" and password "Secret01"
  	When I visit "users/sign_up"
		And I fill in "First name" with "John"
		And I fill in "Last name" with "Doe"
		And I fill in "Email address" with "test@chanintr.com"
		And I fill in "Password" with "Secure01"
		And I fill in "Password confirmation" with "Secure01"
		And I check in checkbox "user[terms_and_conditions]"
		And I click button "Register"
		Then I should see "Email has already been taken"
	
	Scenario: User registration
  	When I visit "users/sign_up"
		And I fill in "First name" with "John"
		And I fill in "Last name" with "Doe"
		And I fill in "Email address" with "test@chanintr.com"
		And I fill in "Password" with "Secure01"
		And I fill in "Password confirmation" with "Secure01"
		And I check in checkbox "user[terms_and_conditions]"
		And I click button "Register"
		Then I should be redirected to "/"
		And I should see "A message with a confirmation link has been sent to your email address. Please follow the link to activate your account."