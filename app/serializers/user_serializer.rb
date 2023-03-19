class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :first_name, :last_name, :pronouns, :twitter_url, :linked_in_url, :portfolio_url, :industry_title, :profile_photo, :user_bio, :member, :founder, :ceo, :featured_member
end
