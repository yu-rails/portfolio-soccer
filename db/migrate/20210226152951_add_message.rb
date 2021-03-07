class AddMessage < ActiveRecord::Migration[5.2]
  def change
    add_column :clears, :message, :text
  end
end
