class CreateTrainings < ActiveRecord::Migration[5.2]
  def change
    create_table :trainings do |t|
      t.text :content
      t.string :tag
      t.date :end
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :trainings, [:user_id, :created_at]
  end
end
