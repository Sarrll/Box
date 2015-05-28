# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

ActionView::Base.field_error_proc = Proc.new do |html_tag, instance_tag|
  # if html_tag =~ /<(input|textarea|select|label)[^>]+class=/
  #   class_attribute = html_tag =~ /class=['"]/
  #   html_tag.insert(class_attribute + 7, "field_with_errors ")
  # elsif html_tag =~ /<(input|textarea|select|label)/
  #   first_whitespace = html_tag =~ /\s/
  #   html_tag[first_whitespace] = " class='field_with_errors' "
  # end
  html_tag.html_safe 
end
