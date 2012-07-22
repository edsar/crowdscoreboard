class TweetCollector

  require 'tweet_record'

  def self.add_tweet(tweet_record)
    screen_name = tweet_record.user_screen_name
    user = find_or_create_user(screen_name,tweet_record.user_twitter_id)
    tweet_record.user_id = user.id
    StatisticsCollector.add_tweet(tweet_record.user_id,tweet_record.status_text)
  end

  def self.find_or_create_user(screen_name,twitter_id)
    logger = Logger.new(STDOUT)
    logger.info("find or create #{screen_name}, #{twitter_id}")
     user = User.find_by_twitter_screen_name(screen_name)
    logger.info("Found user #{user}")
      if(!user)
        user = User.create({"twitter_screen_name"=>screen_name,"twitter_id"=>twitter_id})
        user.save
      end
      logger.debug("The user object is #{user}")
      return user
    end

end