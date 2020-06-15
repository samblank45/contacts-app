class AddLatitudeToContacts < ActiveRecord::Migration[6.0]
  def change
    add_column :contacts, :latitude, :float
  end
end
