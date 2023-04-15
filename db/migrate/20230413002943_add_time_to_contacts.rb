class AddTimeToContacts < ActiveRecord::Migration[7.0]
  def change
    add_column :contacts, :time, :time
  end
end
