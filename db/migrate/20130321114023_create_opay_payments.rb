class CreateOpayPayments < ActiveRecord::Migration
  def change
    create_table :opay_payments do |t|
      t.references :payable, polymorphic: true
      t.string :session_id
      t.string :provider
      t.float :amount
      t.boolean :finished, null: false, default: false

      t.timestamps
    end
    add_index :opay_payments, [:payable_id, :payable_type]
  end
end
