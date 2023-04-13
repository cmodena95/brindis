class AddOrderNumberToContacts < ActiveRecord::Migration[7.0]
  def change
    add_column :contacts, :order_number, :string
  end
end
