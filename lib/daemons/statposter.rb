#!/usr/bin/env ruby

# You might want to change this
ENV["RAILS_ENV"] ||= "development"

require File.dirname(__FILE__) + "/../../config/application"
Rails.application.require_environment!

$running = true
Signal.trap("TERM") do 
  $running = false
end

while($running) do
  
  # Replace this with your code
  Rails.logger.auto_flushing = true
  Rails.logger.info "This daemon is still running at #{Time.now}.\n"

  begin
  player = Player.all.sample
  game = Game.all.sample
  tr = TweetRecord.new
  tr.user_screen_name="rebeccag_dev"
  tr.user_twitter_id=1234567890123
  tr.status_text="@c2sb #g#{game.id}p#{player.id}sFGM"
  Rails.logger.info "generated tweet #{tr.inspect}"
  #TweetCollector.add_tweet(tr)
  #StatisticsCollector.add_tweet(68,"#g17p#{player.id}sFGM")
  #Rails.logger.info "Submitted tweet for player #{player.id} - #{player.name}"
  #Rails.logger.info("Tweet log #{TweetCollector.get_tweet_log.first.inspect}")
  #@c2sb #g17p226sFGM
  rescue => ex
    Rails.logger.info "Exception #{ex.backtrace}"
  end
  #StatisticsCollector.add_tweet(68,"#g17p#{player.id}sFGM")
  #Rails.logger.info "Submitted tweet for player #{player.id} - #{player.name}"

  sleep 5
end