class UserStock < ActiveRecord::Base

  # Relationships
  belongs_to :user
  belongs_to :stock

end
