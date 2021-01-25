class RenameEndColumnToTrainings < ActiveRecord::Migration[5.2]
  def change
    rename_column :trainings, :end, :end_on
  end
end
