class Users::AdministratorController < ApplicationController
    before_action :authenticate_user!
    before_action :verify_admin
    before_action :set_flash, :only => [:index]

    respond_to :html

  	def index
      	@users = User.order(id: :asc)
  		# render :layout => "content-with-sidebar"
  	end

    def new_user
      @resource = User.new
      @resource_name = :user
    end

    def create_user
      
    end

  	def edit_user
  		@resource = User.find_by_id(params[:user_id])
  		@resource_name = :user
  		# render :layout => "content-with-sidebar"
  	end

  	def update_user
  		resource = User.find(params[:user_id])
  		resource.update(user_params)

  		respond_to do |format|

	  		if resource.save
	  			response = { "status" => "success", "message" => "Account ID = #{resource.id} has been updated." , "redirect_to" => administrator_path }.to_json
	        	format.json { render json: response , status: 200 }
	  		else
	  			format.json { render json: resource.errors, status: 422 }
	  		end

  		end

  	end
    
    private
      	def verify_admin
        	unless current_user.is_admin? 
          		redirect_to home_index_path, alert: "Access denied - You are not authorized to access this page."
        	end
      	end

      	def user_params
	      params.require(:user).permit(:first_name, :last_name, :email, :password, :profile_image)
	    end
end
