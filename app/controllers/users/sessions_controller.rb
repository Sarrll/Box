class Users::SessionsController < Devise::SessionsController
before_filter :configure_sign_in_params, only: [:create]
before_action :set_flash, :only => [:new]

  # GET /resource/sign_in
  def new
    super
  end

  # POST /resource/sign_in
  def create
      self.resource = warden.authenticate!(auth_options)

      respond_to do |format| 
        if sign_in(resource_name, resource)
          format.html { redirect_to home_index_path, status: 301, notice: 'Signed in successfully.' }
          resource.is_admin? ? (redirect_path = administrator_path)  : (redirect_path = home_index_path)
          response = { "status" => "success", "message" => "Signed in successfully.", "redirect_to" => redirect_path }.to_json
          format.json { render json: response , status: 200 }
        end
      end
  end

  # DELETE /resource/sign_out
  def destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    set_flash_message :notice, :signed_out if signed_out && is_flashing_format?
    respond_to_on_destroy
  end

  protected

  # You can put the params you want to permit in the empty array.
  def configure_sign_in_params
    devise_parameter_sanitizer.for(:sign_in) << :attribute
  end

  def sign_in_params
    devise_parameter_sanitizer.sanitize(:sign_in)
  end

end
