class CreateGrowthRecords < ActiveRecord::Migration[5.1]
  def change
    create_table :growth_records do |t|
      t.float :height
      t.float :weight
      t.integer :age_of_the_moon

      t.timestamps
    end
  end
end
