class Division < ActiveRecord::Base

	has_many :meetings, dependent: :destroy
	belongs_to :organisation
	belongs_to :user

end
