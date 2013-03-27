class CreateOpayPayments < ActiveRecord::Migration
  def change
    create_table :opay_payments do |t|
      t.references :payable, polymorphic: true
      t.string :session
      t.float :amount
      t.boolean :finished

      t.timestamps
    end
    add_index :opay_payments, [:payable_id, :payable_type]
  end
end
