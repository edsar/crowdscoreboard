class CreateCalculatedGamePlayerStatistics < ActiveRecord::Migration
  def change
    create_table :calculated_game_player_statistics do |t|
      t.integer :game_id
      t.integer :team_id
      t.integer :player_id
      t.integer :count
      t.references :stat_type

      t.timestamps
    end
    add_index :calculated_game_player_statistics, :stat_type_id
  end
end
