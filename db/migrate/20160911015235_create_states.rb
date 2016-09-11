class CreateStates < ActiveRecord::Migration[5.0]
  def change
    create_table :states do |t|
      t.string :label
      t.string :color

      t.timestamps
    end
  end
end
