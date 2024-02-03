class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :full_name
      t.string :phone
      t.string :cellphone
      t.string :address

      t.timestamps
    end
  end
end
