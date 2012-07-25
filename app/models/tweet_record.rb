class TweetRecord

  attr_accessor :user_id
  attr_accessor :status_id
  attr_accessor :user_twitter_id
  attr_accessor :user_screen_name
  attr_accessor :user_full_name
  attr_accessor :status_text
  attr_accessor :processed_successfully
  attr_accessor :error_msgs
  attr_accessor :processed_at

  def init_with_status(status)
    @status_id=status[:id]
    @user_twitter_id=status.user[:id]
    @user_screen_name=status.user.screen_name
    @user_full_name=status.user.name
    @status_text=status.text
    @error_msgs = Array.new
  end

  def add_error!(str)
    @error_msgs = Array.new unless @error_msgs
    @error_msgs.push(str)
  end

  def has_error?
    @error_msgs = Array.new unless @error_msgs
    !@error_msgs.empty?
  end

  def to_s
    if processed_successfully
      "SUCCESS!  #{user_screen_name} : #{status_text}"
    else
      "FAILED TO PROCESS : #{user_screen_name} : #{status_text}, #{error_msgs.inspect}"
    end

  end
end