class CreateMembers < ActiveRecord::Migration[5.0]
  def change
    create_table :members do |t|
      t.string :uid
      t.string :job
      t.string :name
      t.integer :col
      t.integer :row
      t.references :state, foreign_key: true

      t.timestamps
    end
  end
end
