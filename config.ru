require 'bundler'
Bundler.require #requires all gems

$LOAD_PATH.unshift(File.expand_path("app", __dir__))

require 'controllers/task_manager_app'

run TaskManagerApp #has to have a call method that takes envt, rack protocol
