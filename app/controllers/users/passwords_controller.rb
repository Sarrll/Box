class Users::PasswordsController < Devise::PasswordsController
  before_action :set_flash, :only => [:new]

  # GET /resource/password/new
  def new
    super
    # self.resource = resource_class.new
  end

  # POST /resource/password
  def create
    self.resource = resource_class.send_reset_password_instructions(resource_params)
    respond_to do |format| 
      if successfully_sent?(resource)
        format.html { respond_with({}, location: after_sending_reset_password_instructions_path_for(resource_name)) }
        response = { "status" => "success", "message" => "You will receive an email with instructions on how to reset your password in a few minutes.", "redirect_to" => after_sending_reset_password_instructions_path_for(resource) }.to_json
        format.json { render json: response , status: 200 }
      else
        format.html { respond_with resource }
        format.json { render json: resource.errors, status: 422 }
      end
    end
  end

  # GET /resource/password/edit?reset_password_token=abcdef
  def edit
    self.resource = resource_class.new
    set_minimum_password_length
    resource.reset_password_token = params[:reset_password_token]
  end

  # PUT /resource/password
  def update
    self.resource = resource_class.reset_password_by_token(resource_params)
    respond_to do |format| 
      if resource.errors.empty?
        resource.unlock_access! if unlockable?(resource)
        # if Devise.sign_in_after_reset_password
        if false
          flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
          set_flash_message(:notice, flash_message) if is_flashing_format?
          sign_in(resource_name, resource)

          format.html { respond_with resource, location: after_resetting_password_path_for(resource) }
          response = { "status" => "success", "message" => flash_message, "redirect_to" => after_resetting_password_path_for(resource) }.to_json
          format.json { render json: response , status: 200 }
        else
          set_flash_message(:notice, :updated_not_active) if is_flashing_format?
          format.html { respond_with resource, location: new_session_path(resource_name) }
          response = { "status" => "success", "message" => "Your password has been reset. You can now use your new password to sign in.", "redirect_to" => new_session_path(resource) }.to_json
          format.json { render json: response , status: 200 }
        end
      else
        format.html { respond_with resource }
        format.json { render json: resource.errors, status: 422 }
      end
    end
  end

  protected

    def after_resetting_password_path_for(resource)
      super(resource)
    end

    # The path used after sending reset password instructions
    def after_sending_reset_password_instructions_path_for(resource_name)
      super(resource_name)
    end

    def assert_reset_token_passed
      reset_password_token = Devise.token_generator.digest(self, :reset_password_token, params[:reset_password_token])
      recoverable = resource_class.find_by(:reset_password_token => reset_password_token)
      if params[:reset_password_token].blank? or recoverable.nil?
        set_flash_message(:alert, :no_token)
        redirect_to new_session_path(resource_name)
      end
    end
end
