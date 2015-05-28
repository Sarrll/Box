class Users::RegistrationsController < Devise::RegistrationsController
before_filter :configure_sign_up_params, only: [:create]
before_filter :configure_account_update_params, only: [:update]
skip_before_filter :verify_authenticity_token, :only => [:update]
before_action :set_flash, :only => [:edit]

  # GET /resource/sign_up
  def new
    super
  end

  # POST /resource
  def create
    build_resource(sign_up_params)

    respond_to do |format| 

      if resource.save
        if resource.persisted?
          resource.add_role("user")
          if resource.active_for_authentication?
            set_flash_message :notice, :signed_up if is_flashing_format?
            sign_up(resource_name, resource)
              format.html { respond_with resource, location: after_sign_up_path_for(resource) }
              response = { "status" => "success", "message" => "Registered successfully.", "redirect_to" => after_sign_up_path_for(resource) }.to_json
              format.json { render json: response , status: 200 }
          else
            set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
            expire_data_after_sign_in!
            format.html { respond_with resource, location: after_inactive_sign_up_path_for(resource) }
            response = { "status" => "success", "message" => "Please check your email to confirm registration.", "redirect_to" => after_inactive_sign_up_path_for(resource) }.to_json
            format.json { render json: response , status: 200 }
          end
        else
          clean_up_passwords resource
          set_minimum_password_length
          format.html { respond_with resource }
          format.json { render json: resource.errors, status: 422 }
        end
      else
        clean_up_passwords resource
        set_minimum_password_length
        format.html { respond_with resource }
        format.json { render json: resource.errors, status: 422 }
      end 
  
    end
  end

  # GET /resource/edit
  def edit
    set_minimum_password_length
    render :edit 
  end

  # PUT /resource
  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    resource_updated = update_resource(resource, account_update_params)

    respond_to do |format| 
      if resource_updated
        if is_flashing_format?
          flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
            :update_needs_confirmation : :updated
          set_flash_message :notice, flash_key
        end
        sign_in resource_name, resource, bypass: true
        format.html { respond_with resource, location: after_update_path_for(resource) }
        response = { "status" => "success", "message" => "Your account has been updated." , "redirect_to" => edit_user_registration_path }.to_json
        format.json { render json: response , status: 200 }
      else
        clean_up_passwords resource
        format.html { respond_with resource }
        format.json { render json: resource.errors, status: 422 }
      end
    end
  end

  # DELETE /resource
  def destroy
    super
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  def cancel
    super
  end

  protected

    # You can put the params you want to permit in the empty array.
    def configure_sign_up_params
      devise_parameter_sanitizer.for(:sign_up) << [:attribute, :first_name, :last_name, :terms_and_conditions, :profile_image]
    end  

    # You can put the params you want to permit in the empty array.
    def configure_account_update_params
      devise_parameter_sanitizer.for(:account_update) << [:attribute , :first_name , :last_name, :profile_image]
    end

    # The path used after sign up.
    def after_sign_up_path_for(resource)
      super(resource)
    end

    # The path used after sign up for inactive accounts.
    def after_inactive_sign_up_path_for(resource)
      super(resource)
    end

end
