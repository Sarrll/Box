Feature: User signin
  In order to ensure that signin feature are working correctly
		
	Scenario: Accessing login page (Already Logged In)
	  Given I have signed in with valid credential
	  When I visit "/users/sign_in"
		Then I should be redirected to "/users/edit"
	  And I should see "You are already signed in."
	
	Scenario: Signing in with valid credential from welcome page
	  Given I have one confirmed user with email "test@chanintr.com" and password "Secret01"
		And I visit "/"
	  When I fill in "Email" with "test@chanintr.com"
		And I fill in "Password" with "Secret01"
		And I submit the "new_user" form
	  Then I should be redirected to "/users/edit"
		And I should see "Signed in successfully."
	
	Scenario: Signing in with invalid credential from welcome page
		Given I have one confirmed user with email "test@chanintr.com" and password "Secret01"
		And I visit "/"
		When I fill in "Email" with "test@chanintr.com"
		And I fill in "Password" with "Secret00"
		And I submit the "new_user" form
		Then I should see "Invalid email or password"
	
	Scenario: Signing in with valid credential
	  Given I have one confirmed user with email "test@chanintr.com" and password "Secret01"
		And I visit "/users/sign_in"
	  When I fill in "Email" with "test@chanintr.com"
		And I fill in "Password" with "Secret01"
		And I submit the "new_user" form
	  Then I should be redirected to "/users/edit"
		And I should see "Signed in successfully."
		
	Scenario: Signing in with invalid credential
	  Given I have one confirmed user with email "test@chanintr.com" and password "Secret01"
		And I visit "/users/sign_in"
	  When I fill in "Email" with "test@chanintr.com"
		And I fill in "Password" with "Secret00"
		And I submit the "new_user" form
	  Then I should see "Invalid email or password"
	
	