class CreateGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :groups do |t|
      t.string :friends
      t.string :family
      t.string :business
      t.string :boston

      t.timestamps
    end
  end
end
