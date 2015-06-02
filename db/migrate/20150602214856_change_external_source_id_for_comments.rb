class ChangeExternalSourceIdForComments < ActiveRecord::Migration
  def up
    change_column :comments, :external_source_id, :string
  end

  def down
    change_column :comments, :external_source_id, :integer
  end
end
