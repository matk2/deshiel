class Relationship < ActiveRecord::Base
  belongs_to :user
  belongs_to :master, :class_name => 'User', :foreign_key => :master_id

  validates_uniqueness_of :master_id
end
