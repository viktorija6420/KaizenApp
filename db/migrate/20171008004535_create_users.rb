class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string  :first_name
      t.string  :last_name
      t.integer :age
      t.integer :sex
      t.string  :email
      t.string  :phone
      t.string  :role

      t.timestamps
    end
  end
end