class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  #Associations
  has_and_belongs_to_many :roles, join_table: :users_roles

  #Validations
  # validates :first_name, :last_name, :pronouns, :linked_in_url, :twitter_url, :portfolio_url, :industry_title, :profile_photo, :user_bio, presence: true
  # validates :email, uniqueness: true
  # validates :password, length: { minimum: 8 }
  #has_one_attached :profile_photo

  before_validation :assign_default_role

  #Helper Methods
  def assign_default_role
    self.roles << Role.find_by_name('member') if self.roles.empty?
  end

  def role?(role)
    roles.any? { |r| r.name.underscore.to_sym == role }
  end

  def member?
    role?(:member)
  end

  def ceo?
    role?(:ceo)
  end

  def founder?
    role?(:founder)
  end

  def featured_member?
    role?(:featured_member)
  end

  def complete_profile?
    first_name.present? && last_name.present? && pronouns.present? && linked_in_url.present? && twitter_url.present? && portfolio_url.present? && industry_title.present? && profile_photo.attached? && user_bio.present?
  end       
end
