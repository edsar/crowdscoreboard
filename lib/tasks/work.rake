require 'rubygems'
require 'bundler/setup'
require 'daemons'

namespace :jobs do
  desc "Heroku worker"
  task :work do
    exec('ruby ./lib/tasks/tweetdaemon.rb start')
    #Daemons.run ('heartbeat.rb','start')
    #Daemons.run File.dirname(__FILE__) + "/heartbeat.rb", "start"
  end
end

