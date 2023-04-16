class ChangeTime < ActiveRecord::Migration[7.0]
  def change
    change_column :contacts, :time, :time
  end
end
