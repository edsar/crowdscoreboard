require 'rubygems'
require 'tweetstream'

# options = {
#     :app_name   => "my_app",
#     :ARGV       => ['start', '-f', '--', 'param_for_myscript']
#     :dir_mode   => :script,
#     :dir        => 'pids',
#     :multiple   => true,
#     :ontop      => true,
#     :mode       => :exec,
#     :backtrace  => true,
#     :monitor    => true6
#   }

TweetStream.configure do |config|
  config.consumer_key = 'FR21cKcnU9tXg88Sw4Cw'
  config.consumer_secret = 'teMypnRGyaVI7tqZp2SkD3NFJhodLCzmu7Eu6D0p0'
  config.oauth_token = '18312226-8f4cB9oPBLRXbqtMrZcFUMk7icxGg4vvZrGZCJOch'
  config.oauth_token_secret = 'SSLvXnVvJeEFLH2uH5E10nBILbUBTXH1mDe3TfEWE'
  config.auth_method = :oauth
end

puts "TweetStream Client"

# logger = Logger.new('stream.log')
# logger.level = Logger::DEBUG


TweetStream::Client.new.track('Bieber') do |status|
  puts "\n\n\n\n"
  puts "#{status[:id]}"
  puts "#{status.user[:id]} "
  puts "Screen Name: #{status.user.screen_name} User Name: #{status.user.name} "
  puts "Text: #{status.text} "
  puts "Full Text:#{status.full_text} "
  
  # logger.info("#{status.full_text}")

end

#https://github.com/intridea/tweetstream/