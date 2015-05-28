Feature: User signout
  In order to ensure that signout feature are working correctly

	Scenario: Accessing logout page (Not already logged in)
	  When I delete "users/sign_out" via the API
		Then I should be redirected to "/users/sign_out"
	  And I should see "You haven't logged in"

	Scenario: Logout
	  Given I have signed in with valid credential
		When I delete "users/sign_out" via the API
		Then I should be redirected to "/users/sign_in" 
		And I should see "You've logged out successfully"
		
		
		
		