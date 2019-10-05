class CreateEquipment < ActiveRecord::Migration
  def change
     create_table :equipments do |t|
       t.string :name
     end
   end
end
