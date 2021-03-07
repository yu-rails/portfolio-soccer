class ClearDestroy < ActiveRecord::Migration[5.2]
  def change
    execute 'DELETE FROM clears;'
  end
end
