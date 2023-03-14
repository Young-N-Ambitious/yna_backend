class AddFeaturedMemberToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :featured_member, :boolean
  end
end
