require 'rubygems'
require 'bundler/setup'
require 'tweetstream'

## need to stop pidfile creation on heroku (read only file-system)
#class TweetStream::Daemon
#  def start(path, query_parameters = {}, &block) #:nodoc:
#                                                 # Because of a change in Ruvy 1.8.7 patchlevel 249, you cannot call anymore
#                                                 # super inside a block. So I assign to a variable the base class method before
#                                                 # the Daemons block begins.
#    startmethod = super.start
#    Daemons.run_proc(@app_name || 'tweetstream', :multiple => true, :no_pidfiles => true) do
#      startmethod(path, query_parameters, &block)
#    end
#  end
#end
#
#TweetStream::Daemon.new(ENV['TWITTER_USERNAME'], ENV['TWITTER_PASSWORD']).track('OH', 'twitpic', 'http') do |status|
#  puts status.text


# You might want to change this
ENV["RAILS_ENV"] ||= "production"

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


puts("Starting up the Tweet Stream Client")

begin
             puts "begin"
#@client = TweetStream::Daemon.new('crowdscore',{ :multiple => true , :no_pidfiles => true })
rescue => ex
  puts "error"
  puts"Exception #{ex.backtrace}"
end
#@client.userstream do |status|
#  begin
#    puts("#{status.full_text}")
#
#    #tr = TweetRecord.new
#    #tr.user_screen_name=status.user.screen_name
#    #tr.user_twitter_id=status.user[:id]
#    #tr.status_text=status.text
#    #Rails.logger.info "Sending tweet #{tr.inspect}"
#    #TweetCollector.add_tweet(tr)
#  rescue => ex
#    puts"Exception #{ex.backtrace}"
#  end

#end
