class CreateCalculatedGameStatistics < ActiveRecord::Migration
  def change
    create_table :calculated_game_statistics do |t|
      t.integer :game_id
      t.integer :team_id
      t.integer :count
      t.references :stat_type
      
      t.timestamps
    end
  end
end
