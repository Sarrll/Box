class PagesController < ApplicationController
	before_action :render_layout
  	
  	def index

  	end

  	def terms
  		
  	end

  	private

	  	def render_layout
	  		if user_signed_in?
	  			respond_to do |format|
				    format.html { render layout: "content-with-sidebar" , template: "#{controller_name}/#{action_name}/#{action_name}" }
				end
		  	else
		  		respond_to do |format|
				    format.html { render layout: "application" , template: "#{controller_name}/#{action_name}/#{action_name}" }
				end
		  	end
	  	end
end
