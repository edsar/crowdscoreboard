class TweetRecord

  attr_accessor :user_id
  attr_accessor :status_id
  attr_accessor :user_twitter_id
  attr_accessor :user_screen_name
  attr_accessor :user_full_name
  attr_accessor :status_text
  attr_accessor :processed
  attr_accessor :error_msg

  #def initialize(status)
  #  @status_id=status[:id]
  #  @user_twitter_id=status.user[:id]
  #  @user_screen_name=status.user.screen_name
  #  @user_full_name=status.user.name
  #  @status_text=status.text
  #end

end