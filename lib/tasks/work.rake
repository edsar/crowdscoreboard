require 'rubygems'
require 'bundler/setup'

namespace :jobs do
  desc "Heroku worker"
  task :work do
    exec('ruby ./lib/tasks/tweetdaemon.rb start')
  end
end

