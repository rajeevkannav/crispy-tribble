class CreateExtraAttributes < ActiveRecord::Migration[5.2]
  def change
    create_table :extra_attributes do |t|
      t.string :key
      t.string :value
      t.string :kind
      t.integer :source_id

      t.timestamps
    end
  end
end
