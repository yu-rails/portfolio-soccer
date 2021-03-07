class ChangeDatatypeRecord < ActiveRecord::Migration[5.2]
  def change
    change_column :liftings, :record, 'integer USING CAST(record AS integer)'
  end
end
