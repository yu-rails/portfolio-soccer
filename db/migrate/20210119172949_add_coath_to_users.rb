class AddCoathToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :coath, :boolean, default: false, null: false
  end
end
