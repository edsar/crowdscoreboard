require 'twitter'


puts "Twitter search"

Twitter.configure do |config|
  config.consumer_key = 'FR21cKcnU9tXg88Sw4Cw'
  config.consumer_secret = 'teMypnRGyaVI7tqZp2SkD3NFJhodLCzmu7Eu6D0p0'
  config.oauth_token = '18312226-8f4cB9oPBLRXbqtMrZcFUMk7icxGg4vvZrGZCJOch'
  config.oauth_token_secret = 'SSLvXnVvJeEFLH2uH5E10nBILbUBTXH1mDe3TfEWE'
end

@twitter = Twitter::Client.new
#obj = @twitter.search("rebecca", :result_type=> "recent", :rpp=>3, :until => "2012-06-26").results
obj = @twitter.search("Bieber", :result_type=> "recent", :rpp=>3).results

obj.each do | status |
  puts "Status : #{status[:id] } | #{status.from_user} | #{status.from_user_id}| #{status.user} | #{status.full_text}"
#  puts "Status : #{status[:id] } #{status.attrs}"
end

