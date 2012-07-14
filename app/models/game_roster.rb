class GameRoster < ActiveRecord::Base
  attr_accessible :game, :team, :player
  belongs_to :game
  belongs_to :team
  belongs_to :player



  def config(game,team,player)
    self.game=game
    self.team=team
    self.player=player
  end

  def self.generate_entries(game)
    entries=Array.new
    game.home_team.players.each do |x|
       entry = GameRoster.new
       entry.config(game,game.home_team,x)
       entries.push(entry)
    end
    game.visiting_team.players.each do |x|
      entry = GameRoster.new
      entry.config(game,game.visiting_team,x)
      entries.push(entry)
    end
    return entries
  end
end
