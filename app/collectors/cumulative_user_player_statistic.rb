class CumulativeUserPlayerStatistic
  
  # def initialize(player_id,stat_id)
  #     @count=0
  #     @player_id=player_id
  #     @stat_id = stat_id
  #   end
  
  def initialize
    @count=0
  end
  
    
    def increment
      @count = @count+1
    end
   
end