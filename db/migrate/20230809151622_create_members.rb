class CreateMembers < ActiveRecord::Migration[7.0]
  def change
    create_table :members do |t|
      t.string :name
      t.boolean :is_pet, default: false
      t.references :user
      t.timestamps
    end
  end
end
