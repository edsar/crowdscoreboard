class CreateCalculatedGameStatistics < ActiveRecord::Migration
  def change
    create_table :calculated_game_statistics do |t|
      t.integer :count
      t.references :statistic_type
      t.references :team
      t.references :game
      t.timestamps
    end
  end
end
