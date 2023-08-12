class CreateNotes < ActiveRecord::Migration[7.0]
  def change
    create_table :notes do |t|
      t.string :comment
      t.references :user, null: false, foreign_key: true
      t.references :noteable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
