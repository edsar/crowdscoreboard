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
    CalculatedGameStatistic.destroy_all
    
    @game = Game.create!(:name=>'Seattle Storm vs. LA Sparks')
    @storm = Team.create!(:name =>"Seattle Storm")
    @sparks = Team.create!(:name => "LA Sparks")
    
    @st_fgm = StatisticType.find_by_code("FGM")
    @st_3pm = StatisticType.find_by_code("3PM")
    @statistic_types = StatisticType.all
    
    
    index=0
    Player.populate storm_player_names.count do |player|
        player.name = storm_player_names[index]
        index=index+1
        @statistic_types.each do |stat|
        CalculatedGamePlayerStatistic.create!(:player_id=>player.id, :game_id=>@game.id, :team_id=>@storm.id,
             :count=>1+rand(20), :statistic_type=>stat)
        end
    end
    
    Player.populate sparks_player_names.count do |player|
        player.name = sparks_player_names[index]
        index=index+1
        @statistic_types.each do |stat|
        CalculatedGamePlayerStatistic.create!(:player_id=>player.id, :game_id=>@game.id, :team_id=>@sparks.id,
             :count=>1+rand(20), :statistic_type=>stat)
        end
    end
    
    
    
        # 
        # Summary team stats for storm
    @storm_stats = CalculatedGamePlayerStatistic.where("team_id=? and game_id=?",@storm.id, @game.id)
    stormHash = Hash.new
    @storm_stats.each do |stat|
      #puts "#{stat.statistic_type.code} : #{stat.count}"
      existing = stormHash[stat.statistic_type]
      existing = 0 if existing.nil?
      newValue = existing+stat.count
      stormHash[stat.statistic_type]=newValue
    end
   # puts "#{stormHash}"
   
    stormHash.each do|key, value|
      CalculatedGameStatistic.create!( :game_id=>@game.id, :team_id=>@storm.id,
           :count=>value, :statistic_type=>key)
    end
    
     @sparks_stats = CalculatedGamePlayerStatistic.where("team_id=? and game_id=?",@sparks.id, @game.id)
      sparksHash = Hash.new
      @sparks_stats.each do |stat|
        #puts "#{stat.statistic_type.code} : #{stat.count}"
        existing = sparksHash[stat.statistic_type]
        existing = 0 if existing.nil?
        newValue = existing+stat.count
        sparksHash[stat.statistic_type]=newValue
      end
     # puts "#{stormHash}"

      sparksHash.each do|key, value|
        CalculatedGameStatistic.create!( :game_id=>@game.id, :team_id=>@sparks.id,
             :count=>value, :statistic_type=>key)
      end
    
    
  end
end