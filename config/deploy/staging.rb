set :domain, 'alpha.jumpstart.ge'
set :user, 'reformeter-staging'
set :application, 'ReforMeter-Staging'
# easier to use https; if you use ssh then you have to create key on server
set :repository, 'https://github.com/JumpStartGeorgia/ReforMeter.git'
set :web_url, ENV['STAGING_WEB_URL']
set :visible_to_robots, false
