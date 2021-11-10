class AddActivationToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :activation_digest, :string
    add_column :users, :status, :integer
    add_column :users, :status_at, :datetime
  end
end
