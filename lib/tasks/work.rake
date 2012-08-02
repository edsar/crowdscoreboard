namespace :jobs do
  desc "create Game roster"

  task :work => :environment do

    exec('ruby lib/tasks/tweetdaemon.rb run')
  end
end

