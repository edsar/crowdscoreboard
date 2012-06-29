namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    require 'populator'
    
    [Game, Team, Player].each(&:delete_all)
    player_names = ["Sue Bird","Jessica Davenport","Temeka Johnson","Lauren Jackson", 
      "Tina Thompson","Katie Smith","Tanisha Wright", "Alysha Clark","Shekinna Stricklen","Camille Little"]
      
    Team.populate 10 do |team|
      team.name = Populator.words(1..3).titleize
      # Product.populate 10..100 do |product|
      #        product.category_id = category.id
      #        product.name = Populator.words(1..5).titleize
      #        product.description = Populator.sentences(2..10)
      #        product.price = [4.99, 19.95, 100]
      #        product.created_at = 2.years.ago..Time.now
      #      end
    end
    index=0
   
    Player.populate 10 do |player|
        player.name = player_names[index]
      puts player_names[index]
      index=index+1
    end

   
  end
end