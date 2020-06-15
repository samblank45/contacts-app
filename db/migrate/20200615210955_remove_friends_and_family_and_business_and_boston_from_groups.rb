class RemoveFriendsAndFamilyAndBusinessAndBostonFromGroups < ActiveRecord::Migration[6.0]
  def change
    remove_column :groups, :friends, :string
    remove_column :groups, :family, :string
    remove_column :groups, :business, :string
    remove_column :groups, :boston, :string
  end
end
