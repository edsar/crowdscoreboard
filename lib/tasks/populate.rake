namespace :db do
  desc "create Game roster"
  require 'populator'
  
  task :populate => :environment do
    
    storm_player_names = ["Sue Bird","Lauren Jackson", "Tina Thompson",
        "Katie Smith","Tanisha Wright", "Alysha Clark","Shekinna Stricklen","Camille Little"]
    
    sparks_player_names = ["Nicky Anosike","Alana Beard", "April Sykes",
            "Coco Miller","DeLisha Milton-Jones","Jenna O'Hea","Jantel Lavender"]
             

    Game.destroy_all
    Team.destroy_all
    Player.destroy_all
    CalculatedGamePlayerStatistic.destroy_all
    
    @game = Game.create!(:name=>'Seattle Storm vs. LA Sparks')
    @storm = Team.create!(:name =>"Seattle Storm")
    @sparks = Team.create!(:name => "LA Sparks")
    
          @st_fgm = StatisticType.find_by_code("FGM")
          @st_3pm = StatisticType.find_by_code("3PM")
    
    
    index=0
    Player.populate storm_player_names.count do |player|
        player.name = storm_player_names[index]
        index=index+1
        CalculatedGamePlayerStatistic.create!(:player_id=>player.id, :game_id=>@game, :team_id=>@storm,
             :count=>1+rand(20), :statistic_type=>@st_fgm)
    end
    
    Player.populate sparks_player_names.count do |player|
        player.name = sparks_player_names[index]
        index=index+1
        CalculatedGamePlayerStatistic.create!(:player_id=>player.id, :game_id=>@game, :team_id=>@sparks,
             :count=>1+rand(20), :statistic_type=>@st_fgm)
    end
    
    
  end
end