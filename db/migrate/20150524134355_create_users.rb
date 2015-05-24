class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :login
      t.string :name
      t.string :email
      t.integer :type

      t.timestamps null: false
    end
  end
end
