class CreateStatisticTypes < ActiveRecord::Migration
  def change
    create_table :statistic_types do |t|
      t.string :code
      t.integer :points

      t.timestamps
    end
  end
end
