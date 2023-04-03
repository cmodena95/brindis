class ChangeEventTimes < ActiveRecord::Migration[7.0]
  def change
    rename_column :events, :time, :start_time
    add_column :events, :end_time, :time
  end
end
