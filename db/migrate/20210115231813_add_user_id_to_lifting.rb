class AddUserIdToLifting < ActiveRecord::Migration[5.2]
  def up
    execute 'DELETE FROM liftings;'
    add_reference :liftings, :user, null: false,  index: true
  end
  def down
    remove_reference :liftings, :user, index: true
  end
end
