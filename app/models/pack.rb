class Pack < ActiveRecord::Base

	validates :title, presence: true
	belongs_to :meeting

end
