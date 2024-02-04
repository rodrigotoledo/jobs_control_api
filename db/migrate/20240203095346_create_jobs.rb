class CreateJobs < ActiveRecord::Migration[7.1]
  def change
    create_table :jobs do |t|
      t.string :title, null: false
      t.references :user, null: false, foreign_key: true
      t.text :description, null: false
      t.string :company, null: false
      t.string :location, null: false
      t.string :job_type, null: false
      t.string :category, null: false
      t.decimal :salary, precision: 10, scale: 2
      t.text :requirements, null: false
      t.text :responsibilities, null: false
      t.string :status, null: false, default: "open"

      t.timestamps
    end
  end
end
