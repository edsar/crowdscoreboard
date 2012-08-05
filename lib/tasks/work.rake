require 'rubygems'
require 'bundler/setup'
require 'daemons'

namespace :jobs do
  desc "Heroku worker"
  task :start do
    exec('ruby ./lib/daemons/statposter_ctl start')
    #Daemons.run ('heartbeat.rb','start')
    #Daemons.run File.dirname(__FILE__) + "/heartbeat.rb", "start"
  end
  desc "Heroku worker"
  task :stop do
    exec('ruby ./lib/daemons/statposter_ctl stop')
    #Daemons.run ('heartbeat.rb','start')
    #Daemons.run File.dirname(__FILE__) + "/heartbeat.rb", "start"
  end
end

