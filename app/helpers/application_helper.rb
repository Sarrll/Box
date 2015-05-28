module ApplicationHelper
  def resource_name
  	:user
  end
 
  def resource
   	@resource ||= User.new
  end
 
  def devise_mapping
  	@devise_mapping ||= Devise.mappings[:user]
  end

  # execute a block with a different format (ex: an html partial while in an ajax request)
	def with_format(format, &block)
	  old_formats = formats
	  self.formats = [format]
	  block.call
	  self.formats = old_formats
	  nil
	end

  def set_flash 
    @status = cookies[:status]
    @message = cookies[:message]
    cookies.delete :status 
    cookies.delete :message
  end

  def set_minimum_password_length
    if devise_mapping.validatable?
      @minimum_password_length = resource_class.password_length.min
    end
  end

  def successfully_sent?(resource)
    notice = if Devise.paranoid
      resource.errors.clear
      :send_paranoid_instructions
    elsif resource.errors.empty?
      :send_instructions
    end

    if notice
      set_flash_message :notice, notice if is_flashing_format?
      true
    end
  end

end
