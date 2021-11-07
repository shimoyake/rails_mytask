class AddNameToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :user_name, :string
    add_column :users, :user_introduction, :strign
    add_column :users, :user_image, :string
  end
end
