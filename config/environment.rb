require 'bundler'
Bundler.require # bundle library, require all gems in gemfile
#if you run bundle from terminal, makes sure everything is installed on system

# get the path of the root of the app, don't expect it to change, dir is current directory, one level above config which is task manager.
#app root is string of a file path
APP_ROOT = File.expand_path("..", __dir__)

# require the controller(s), dir.glob makes an array of strings, one controller. same as requiring all controllers by hardcoding
Dir.glob(File.join(APP_ROOT, 'app', 'controllers', '*.rb')).each { |file| require file }

# require the model(s)
Dir.glob(File.join(APP_ROOT, 'app', 'models', '*.rb')).each { |file| require file }

# configure TaskManagerApp settings
class TaskManagerApp < Sinatra::Base
  set :method_override, true #can see put and delete methods
  set :root, APP_ROOT #set root to file path constant
  set :views, File.join(APP_ROOT, "app", "views") #where views is 
  set :public_folder, File.join(APP_ROOT, "app", "public")
end
