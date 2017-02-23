set :domain, 'reformeter.jumpstart.ge'
set :user, 'reformeter'
set :application, 'Reformeter'
# easier to use https; if you use ssh then you have to create key on server
set :repository, 'https://github.com/JumpStartGeorgia/ReforMeter.git'
set :branch, 'v2.0'
set :web_url, 'reformeter.iset-pi.ge'
set :secondary_web_url, 'reformeter.jumpstart.ge'
set :use_ssl, true
set :puma_worker_count, '1'
set :puma_thread_count_min, '1'
set :puma_thread_count_max, '16'
