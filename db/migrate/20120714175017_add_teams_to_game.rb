class AddTeamsToGame < ActiveRecord::Migration
  def change
    change_table :games do |t|
      t.references :home_team
      t.references :visiting_team
    end
  end
end
