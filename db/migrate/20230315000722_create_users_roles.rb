# db/migrate/YYYYMMDDHHMMSS_create_user_roles.rb
class CreateUsersRoles < ActiveRecord::Migration[6.1]
  def change
    create_table :users_roles, id: false do |t|
      t.references :user, foreign_key: true
      t.references :role, foreign_key: true
    end

    add_index :users_roles, [:user_id, :role_id]
  end
end
