class AddRoleToUser < ActiveRecord::Migration[5.0]
  def up
    add_column :users, :role, :integer

    me = User.create!(name: 'Joshua Wolfe', email: 'jwolfe@wfsbs.com', password: 'fakepass', password_confirmation: 'fakepass')
    me.admin!
  end

  def down
    remove_column :users, :role
  end
end
