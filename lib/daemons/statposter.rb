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
  StatisticsCollector.add_tweet(68,"#g17p#{player.id}sFGM")
  Rails.logger.info "Submitted tweet for player #{player.id} - #{player.name}"

  rescue => ex
    Rails.logger.info "Exception #{ex.backtrace}"
  end
  #StatisticsCollector.add_tweet(68,"#g17p#{player.id}sFGM")
  #Rails.logger.info "Submitted tweet for player #{player.id} - #{player.name}"

  sleep 3
end