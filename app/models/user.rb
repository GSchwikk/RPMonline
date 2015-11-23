class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

 	has_many :updates, dependent: :destroy
 	has_many :steps, dependent: :destroy

	validates :first_name, :last_name, presence: true
end
