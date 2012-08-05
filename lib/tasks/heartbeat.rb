#!/usr/bin/env ruby

# You might want to change this
ENV["RAILS_ENV"] ||= "production"

require File.dirname(__FILE__) + "/../../config/application"
Rails.application.require_environment!

$running = true
Signal.trap("TERM") do
  $running = false
end

while($running) do

  # Replace this with your code
  #Rails.logger.auto_flushing = true
 puts "This daemon is still running at #{Time.now}.\n"


  sleep 5
end