namespace :db do
  desc "create Game roster"
  
  task :populate => :environment do
    
    storm_player_names = ["Sue Bird","Lauren Jackson", "Tina Thompson",
        "Katie Smith","Tanisha Wright", "Alysha Clark","Shekinna Stricklen","Camille Little"]
    
    sparks_player_names = ["Nicky Anosike","Alana Beard", "April Sykes",
            "Coco Miller","DeLisha Milton-Jones","Jenna O'Hea","Jantel Lavender"]
             

    Rails.cache.clear
    Game.destroy_all
    Team.destroy_all
    Player.destroy_all
    User.destroy_all
    UserReportedStatistic.destroy_all
    CalculatedGamePlayerStatistic.destroy_all
    CalculatedGameStatistic.destroy_all
    
    StatisticType.delete_all   
    StatisticType.create!( :code => "FGM", :points => 2)
    StatisticType.create!( :code => "3PM", :points => 3)
    
    User.create!(:twitter_screen_name=>'SparksFan')
    User.create!(:twitter_screen_name=>'StormFan')
    User.create!(:twitter_screen_name=>'SportsFan')
    User.create!(:twitter_screen_name=>'SueBirdFan')
   
    
    @game = Game.create!(:name=>'Seattle Storm vs. LA Sparks')
    @storm = Team.create!(:name =>"Seattle Storm")
    @sparks = Team.create!(:name => "LA Sparks")
    
    @st_fgm = StatisticType.find_by_code("FGM")
    @st_3pm = StatisticType.find_by_code("3PM")
    @statistic_types = StatisticType.all
   
    
    
    index=0
    storm_player_names.each do |name|
      player = Player.create!(:name=>name, :team=>@storm)
    end
    sparks_player_names.each do |name|
        player = Player.create!(:name=>name, :team=>@sparks)
    end
      
    
  end
end