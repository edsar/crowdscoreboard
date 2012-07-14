class Player < ActiveRecord::Base
  attr_accessible :name, :team
  belongs_to :team
end
