class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.time :time
      t.date :date
      t.string :address
      t.boolean :vaccination, default: false
      t.boolean :flea_treatment, default: false
      t.boolean :worm_treatment, default: false
      t.references :member
      t.timestamps
    end
  end
end
