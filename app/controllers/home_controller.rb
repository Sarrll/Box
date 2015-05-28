class HomeController < ApplicationController
	
  	def index
  		if user_signed_in? 
  			redirect_to edit_user_registration_url
  		else
        set_flash
  			render layout: "welcome"
  		end
  	end

  	private

end
