
class Role < ApplicationRecord

  rolify 
  # Validations
    validates :name, presence: true, uniqueness: true
    
    # Associations
    has_and_belongs_to_many :users, join_table: :users_roles

    # Available Roles
    AVAILABLE_ROLES = %w[founder ceo admin member featured_member].freeze

    # Scopes
    scope :by_name, -> { order(name: :asc) }
  end
  