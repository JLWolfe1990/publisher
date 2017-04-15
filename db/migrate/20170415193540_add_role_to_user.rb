class AddRoleToUser < ActiveRecord::Migration[5.0]
  def up
    add_column :users, :role, :integer

    User.first.admin!
  end

  def down
    remove_column :users, :role
  end
end
