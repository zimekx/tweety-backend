class AddFieldsForExternalSourceToComments < ActiveRecord::Migration
  def change
    add_column :comments, :type, :string
    add_column :comments, :external_source_id, :integer
    add_column :comments, :external_user_id, :string
    add_column :comments, :external_user_name, :string
  end
end
