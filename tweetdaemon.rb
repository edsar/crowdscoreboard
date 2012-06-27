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

puts "TweetStream Daemon"

TweetStream::Daemon.new('tracker', options={:multiple => false, :monitor =>true }).track('Bieber') do |status|
  # save data here
end


#https://github.com/intridea/tweetstream/