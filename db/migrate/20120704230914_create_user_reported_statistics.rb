class CreateUserReportedStatistics < ActiveRecord::Migration
  def change
    create_table :user_reported_statistics do |t|
      t.references :statistic_type
      t.references :game
      t.references :team
      t.references :player
      t.references :user

      t.timestamps
    end
    add_index :user_reported_statistics, :statistic_type_id
    add_index :user_reported_statistics, :game_id
    add_index :user_reported_statistics, :team_id
    add_index :user_reported_statistics, :player_id
    add_index :user_reported_statistics, :user_id
  end
end
