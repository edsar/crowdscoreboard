#!/usr/bin/env ruby

# You might want to change this
ENV["RAILS_ENV"] ||= "development"

require File.dirname(__FILE__) + "/../../config/application"
Rails.application.require_environment!

# config info for rebeccag_cs1
TweetStream.configure do |config|
  config.consumer_key = 'uqNzZcwYY2j95xmlEuSerA'
  config.consumer_secret = 'tIwagGNPQebYnCPTzFd6Se4kykrFVJCIakR35tiiH8'
  config.oauth_token = '717389262-4a0vldN72xgwAYEwEgS1lRTRmeF79Ds3ddtJic7X'
  config.oauth_token_secret =   'sYVEQN3ePwYolqvrD7VxjUxBjOFaMOkCJrLcoHP81dU'
  config.auth_method = :oauth
end


#Twitter.configure do |config|
#  config.consumer_key = 'FR21cKcnU9tXg88Sw4Cw'
#  config.consumer_secret = 'teMypnRGyaVI7tqZp2SkD3NFJhodLCzmu7Eu6D0p0'
#  config.oauth_token = '18312226-8f4cB9oPBLRXbqtMrZcFUMk7icxGg4vvZrGZCJOch'
#  config.oauth_token_secret = 'SSLvXnVvJeEFLH2uH5E10nBILbUBTXH1mDe3TfEWE'
#end

@client = nil

$running = true
Signal.trap("TERM") do 
  $running = false
  if @client
    @client.stop
 end
end

while($running) do
  
  # Replace this with your code
  Rails.logger.auto_flushing = true
  Rails.logger.info "Twitter daemon is  running at #{Time.now}.\n"

  @client = TweetStream::Client.new
  @client.userstream do |status|
   begin
   Rails.logger.info("#{status.full_text}")

    tr = TweetRecord.new
    tr.user_screen_name=status.user.screen_name
    tr.user_twitter_id=status.user[:id]
    tr.status_text=status.text
    Rails.logger.info "Sending tweet #{tr.inspect}"
    TweetCollector.add_tweet(tr)
   rescue => ex
   Rails.logger.info "Exception #{ex.backtrace}"
  end
  end


end