class TweetCollector

  def self.add_tweet(tweet_record)
    unless tweet_record.user_id
      user = find_or_create_user(tweet_record.user_screen_name,tweet_record.user_twitter_id)
      if user
        tweet_record.user_id = user.id
      end
    end
    if tweet_record.user_id
      process(tweet_record)
    else
      tweet_record.add_error("couldn't find user or no user specified'")
    end
  end

  def self.get_tweet_log
    Rails.cache.fetch("tweet_log"){Array.new}
  end

  private

  def self.add_tweet_log(tweet)
    tweet_list = Rails.cache.fetch("tweet_log"){Array.new}
    tweet_list.push(tweet)
    Rails.logger.info "Pushing tweet record #{tweet}"
    Rails.cache.write("tweet_log",tweet_list)
  end

  def self.process(tweet_record)
    logger =  Rails.logger
    logger.info("Tweet record #{tweet_record.inspect}")
    values = tweet_record.status_text.scan(/\#g(\d+)p(\d+)s(\w+)/).first
    logger.info("Tweet record #{tweet_record.status_text}")
    if !values || values.count!=3
      tweet_record.add_error!("Unable to parse tweet, unrecognized format #{tweet_record.status_text}")
    end

    game_id=0
    player_id=0
    game_roster=nil
    statistic_type=nil

    unless tweet_record.has_error?
      game_id=values[0]
      player_id=values[1]
      stat_code=values[2]

      statistic_type = StatisticType.first( :conditions => [ "lower(code) = ?", stat_code.downcase ])
      errors.push("Unrecognized statistic type #{stat_code}") unless statistic_type
      game = Game.find_by_id(game_id)
      tweet_record.add_error!("Unknown game id #{game_id}") unless game
      player = Player.find_by_id(player_id)
      tweet_record.add_error!("Unknown player #{player_id}") unless player

    end
    unless tweet_record.has_error?
      game_roster = GameRoster.where("game_id=? and player_id=? ",game_id,player_id).first

      tweet_record.add_error!("Unable to find player #{player_id} on team roster for game #{game_id} ")  unless game_roster
    end

    if tweet_record.has_error?
      tweet_record.processed_successfully=false
      tweet_record.processed_at=DateTime.now
      logger.info("failed to parse tweet #{tweet_record.inspect}")
    else
      logger.info("Successfully parsed tweet, adding stat ")
      tweet_record.processed_successfully=true
      tweet_record.processed_at=DateTime.now
      StatisticsCollector.add_stat(tweet_record.user_id,game_roster.game.id,game_roster.team.id,game_roster.player.id,statistic_type.id)
    end
    logger.info("Will add tweet log #{tweet_record.inspect}")
    add_tweet_log(tweet_record)

  end

  def self.find_or_create_user(screen_name,twitter_id)
    logger = Rails.logger
    logger.info("find or create #{screen_name}, #{twitter_id}")
     user = User.find_by_twitter_screen_name(screen_name)
    logger.info("Found user #{user}")
      unless user
        user = User.create({:twitter_screen_name => screen_name,:twitter_id=>twitter_id})
        user.save
      end
      logger.debug("The user object is #{user}")
      return user
    end

end