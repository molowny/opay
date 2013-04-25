class CreateOpayPayments < ActiveRecord::Migration
  def change
    create_table :opay_payments do |t|
      t.references :payable, polymorphic: true
      t.string :session_id, null: false
      t.string :provider, null: false
      t.integer :amount, null: false
      t.boolean :finished, null: false, default: false
      t.string :status

      t.timestamps
    end
    add_index :opay_payments, [:payable_id, :payable_type]
    add_index :opay_payments, :session_id, unique: true
  end
end
