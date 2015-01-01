class AddUserToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :user_id, :integer
    add_column :projects, :description, :string
    add_column :works, :description, :string
  end
end
