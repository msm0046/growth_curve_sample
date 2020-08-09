class AddColumnAge < ActiveRecord::Migration[5.1]
  def change
    add_column :growth_records, :age, :integer
  end
end
