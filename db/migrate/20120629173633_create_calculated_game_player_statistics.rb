class CreateCalculatedGamePlayerStatistics < ActiveRecord::Migration
  def change
    create_table :calculated_game_player_statistics do |t|
      t.integer :count
      t.references :statistic_type
      t.references :game
      t.references :team
      t.references :player
      t.timestamps
    end
  end
end
