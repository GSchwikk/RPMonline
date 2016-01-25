class Pack < ActiveRecord::Base

	validates :title, presence: true
	belongs_to :meeting
    belongs_to :user

	has_many :updates, dependent: :destroy
 	has_many :steps, dependent: :destroy

 	has_and_belongs_to_many :kpis

end
