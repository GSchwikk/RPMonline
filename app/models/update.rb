
class Update < ActiveRecord::Base

validates :text, :update_type, :date, presence: true
belongs_to :user
belongs_to :pack

scope :update_type, -> (update_type) { where update_type: update_type }

end
