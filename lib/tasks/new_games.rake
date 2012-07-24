namespace :db do
  desc "create Game roster"

  task :new_games => :environment do

    team1_player_names = ["a","b","c"]

    team2_player_names = ["d","e","f"]


    @team1 = Team.create!(:name =>"Team1")
    @team2 = Team.create!(:name => "Team2")

    index=0
    team1_player_names.each do |name|
      player = Player.create!(:name=>name, :team=>@team1)
    end
    team2_player_names.each do |name|
      player = Player.create!(:name=>name, :team=>@team2)
    end

    @game1 = Game.create!(:name=>'Game 1', :home_team=>@team1, :visiting_team=>@team2)
    @game2 = Game.create!(:name=>'Game 2', :home_team=>@team1, :visiting_team=>@team2)
    @entries = GameRoster.generate_entries(@game1)

    @entries.each do |x|
      x.save!
    end
    @entries = GameRoster.generate_entries(@game2)

    @entries.each do |x|
      x.save!
    end
  end
end