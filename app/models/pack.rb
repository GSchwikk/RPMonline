class Pack < ActiveRecord::Base

	validates :title, presence: true
	belongs_to :meeting

	has_many :updates, dependent: :destroy
 	has_many :steps, dependent: :destroy

end
