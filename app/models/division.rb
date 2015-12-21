class Division < ActiveRecord::Base

	has_many :meetings
	belongs_to :organisation
	belongs_to :user

end
