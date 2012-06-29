class User < ActiveRecord::Base
  attr_accessible :twitter_id, :twitter_screen_name
end
