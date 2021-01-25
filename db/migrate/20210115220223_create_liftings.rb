class CreateLiftings < ActiveRecord::Migration[5.2]
  def change
    create_table :liftings do |t|
      t.string :record
      t.text :remark

      t.timestamps
    end
  end
end
