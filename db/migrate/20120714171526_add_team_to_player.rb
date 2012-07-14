class AddTeamToPlayer < ActiveRecord::Migration
  def change
   change_table :players do |t|
      t.references :team
    end
  end

end
