class RemoveEmailAndAddFacebookIdForUsers < ActiveRecord::Migration
  def change
    remove_column :users, :email
    add_column :users, :facebook_id, :string
  end
end
