class Pack < ActiveRecord::Base

	validates :title, presence: true
	belongs_to :meeting
    belongs_to :user
    belongs_to :organisation

	has_many :updates, dependent: :destroy
 	has_many :steps, dependent: :destroy

end
