class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email

      t.timestamps   #creates two magic columns called created_at and updated_at
    end
  end
end
