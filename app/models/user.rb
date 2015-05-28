class User < ActiveRecord::Base
  has_and_belongs_to_many :roles
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
         
  validates_presence_of :password_confirmation, :on => [:create], :message => "can't be blank"
  validates_presence_of :first_name, :on => :create, :message => "can't be blank"
  validates_presence_of :last_name, :on => :create, :message => "can't be blank"
  validates_format_of :first_name, :with => /^[\w&.\-]*$/, :message => "is invalid",:multiline => true
  validates_format_of :last_name, :with => /^[\w&.\-]*$/, :message => "is invalid,",:multiline => true
  validates_acceptance_of :terms_and_conditions, :accept => "1", :message => "You must accept the terms of service"
  

  has_attached_file :profile_image, :styles => { :medium => "300x300#", :thumb => "50x50#" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :profile_image, :content_type => /\Aimage\/.*\Z/

  def is_admin?
    self.roles.find_by_name("admin") ? true : false
  end

  def add_role(role_name) 
    self.roles << Role.find_or_create_by(:name => role_name)
  end

  def full_name 
    self.first_name + " " + self.last_name
  end

end
