class CreateWorkshops < ActiveRecord::Migration[7.0]
  def change
    create_table :workshops do |t|
      t.string :name
      t.text :description
      t.date :date
      t.time :time

      t.timestamps
    end
  end
end
