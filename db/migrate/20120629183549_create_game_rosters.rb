class CreateGameRosters < ActiveRecord::Migration
  def change
    create_table :game_rosters do |t|
      t.references :player
      t.references :team
      t.references :game
      t.timestamps
    end
  end
end
