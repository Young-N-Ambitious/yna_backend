class DropUserRolesTable < ActiveRecord::Migration[6.1]
  def change
    drop_table :user_roles
  end
end
