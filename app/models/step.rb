class Step < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :pack

  validates :description, :status, :due_date, presence: true
end
