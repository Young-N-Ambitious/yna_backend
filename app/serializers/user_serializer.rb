class UserSerializer < ActiveModel::Serializer
  attributes :id, :member_id, :first_name, :last_name, :pronouns, :twitter_url, :linked_in_url, :portfolio_url, :industry_title, :profile_photo, :user_bio, :member, :founder, :admin, :ceo, :featured_member
  
  has_many :email
end
