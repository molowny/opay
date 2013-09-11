class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :name
      t.string :amount
      t.boolean :finished, null: false, default: false

      t.timestamps
    end
  end
end
