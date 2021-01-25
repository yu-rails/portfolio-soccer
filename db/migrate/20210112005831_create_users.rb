class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :password_digest, null: false
      t.string :nickname, null: false

      t.timestamps
      t.index :nickname, unique: true
    end
  end
end
