class Role < ActiveRecord::Base
  has_and_belongs_to_many :users
  validates_presence_of :name, :message => "can't be blank"
  validates_format_of :name, :with => /^[\w\d]+$/, :message => "is invalid",:multiline => true
  validates_uniqueness_of :name, :message => "must be unique"
end
