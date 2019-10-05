class AddUserIdToEquipment < ActiveRecord::Migration
  def change
  add_column :equipments, :user_id, :integer
end
end
