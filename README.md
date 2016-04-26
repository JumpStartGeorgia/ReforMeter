# ISET's ReforMeter

## The Technologies
ReforMeter uses the following technologies:

- Ruby: 2.3
- Rails: 4.2.6
- Authentication: Devise 3.5.6
- Authorization: CanCanCan 1.10.1
- Model/Data Translations: Globalize 5.0
- Responsive Design: Twitter Bootstrap Rails 3.2.0
- Error Emails: Exception Notification 4.1
- Database: MySQL (mysql2 0.3.18)
- Deploy: Mina 0.3.8
- Rails Server: Puma 3.4.0
- HTML Server: Nginx


## Getting Started

### Requirements
The following software/apps should be installed in order to use the application:
* git
* rbenv
* Ruby 2.x
* nginx - for staging/production server

### Setting up dev box
Run the following from the command line:
1. git clone git@github.com:JumpStartGeorgia/ReforMeter.git
2. bundle install
3. rake db:create
4. rake db:seed load_test_data=true   (this loads test data into the tables)
5. create .env file from .env.example and fill in the variable values


## Using Mina

### Setup

Add your stage-specific deploy variables to the files in config/deploy.

### Deploy

1. Run `mina setup`
  - The default stage is set to `staging`, so this command is equivalent to the command `mina staging setup`
2. Run `mina rails:edit_env` and add your project secrets
3. Run `mina deploy first_deploy=true --verbose`
  - If you get the error “Host key verification failed” when mina tries to clone the git repository, you may have to add your repository’s host to known_hosts on your server. You can run one of these two commands on the server to fix that (works for github):
    - `ssh-keyscan -H github.com >> ~/.ssh/known_hosts`
      - Adds github to user’s known hosts
    - `ssh-keyscan -H github.com >> etc/ssh/ssh_known_hosts`
      - Adds github to known hosts for all users
4. Run `mina post_setup sudo_user=<username>`, where `<username>` is a user with sudo permissions on your server. You will need to enter the user’s password a number of times to execute the sudo commands.
5. Deploy further changes with `mina deploy` or `mina deploy --verbose`
6. Repeat these steps for your other stages, simply by inserting the stage name into the command after `mina`. Examples:
  - `mina setup` --> `mina production setup`
  - `mina deploy precompile=true --verbose` --> `mina production deploy precompile=true --verbose`

#### Options (mina deploy <options>)

[precompile=true]  forces precompile assets
[verbose=true]            outputs more information (default is quieter and prettier)

### Commands

Run `mina -T` for a list of mina's commands.

### Precompile Assets Method

Unlike in the standard Mina deploy, assets are precompiled locally and rsynced up to the server in this starter-template. The method is as follows:

1. Determine whether to precompile the assets
   a. If the flag 'precompile=true' is set, then precompile assets
   b. Use git to view difference in the assets files between the commit on the server
      and the commit on the local machine. If there is a difference, precompile assets
   c. If cannot determine the commit on the server, show error and ask user to run deploy with 'precompile=true'
   d. If git diff gives an error, precompile assets
2. If not precompiling assets, skip to step 3. Otherwise...
   a. precompile assets locally
   b. sync tmp/assets on server with local precompiled assets
3. During deploy, copy assets from tmp/assets to current/public/assets

### Puma Jungle (Controlling Multiple Puma Apps)

Setting up the Puma Jungle on the server allows you to run commands such as start, stop, status, etc. for multiple puma apps at one time. You can also configure it to restart all apps whenever the server reboots.

In order to setup the jungle, follow [these steps](https://github.com/puma/puma/tree/master/tools/jungle/init.d). You may have to modify the default scripts to work on your server; if things don't work out of the box, try consulting [this guide](http://dev.mensfeld.pl/2014/02/puma-jungle-script-fully-working-with-rvm-and-pumactl/).

If your primary puma jungle script is stored at the default location `/etc/init.d/puma`, here are some commands you can use (you may have to run with sudo):
 - `/etc/init.d/puma start`
 - `/etc/init.d/puma stop`
 - `/etc/init.d/puma status`
 - `/etc/init.d/puma restart`

This starter template provides access to the puma jungle through mina commands, such as `mina puma:jungle:start`. Run `mina -T puma:jungle` to see all these commands.
