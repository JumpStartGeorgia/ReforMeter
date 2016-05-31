set :domain, 'alpha.jumpstart.ge'
set :user, 'prisoners-staging'
set :application, 'Starter-Template-Production'
# easier to use https; if you use ssh then you have to create key on server
set :repository, 'git@github.com:JumpStartGeorgia/Starter-Template.git'
set :branch, 'master'
set :web_url, ENV['PRODUCTION_WEB_URL']
