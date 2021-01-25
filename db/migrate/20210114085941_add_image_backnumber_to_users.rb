class AddImageBacknumberToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :image_name, :string
    add_column :users, :back_number, :string
  end
end
