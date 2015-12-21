class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

 	has_many :updates, dependent: :destroy
 	has_many :steps, dependent: :destroy
  has_many :meetings
  has_many :divisions
  belongs_to :organisation

	validates :first_name, :last_name, presence: true

	ROLES = %i[org_owner div_owner meeting_owner pack_owner]

  def has_role?(role)
    roles.include?(role.to_s)
  end

  def role?(role_name)
    return self.role.present? && self.role.name == role_name.to_s
  end



end
