class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :last_name
      t.string :institution
      t.string :email
      t.string :password_digest
      t.string :remember_digest
      t.boolean :contributor, default: false
      t.boolean :editor, default: false
      t.boolean :admin, default: false
      t.string :activation_digest
      t.boolean :activated, default: false
      t.datetime :activated_at
      t.string :reset_digest
      t.datetime :reset_sent_at
      t.datetime :last_seen_at

      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
