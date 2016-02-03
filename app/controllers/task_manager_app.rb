require 'yaml/store' #just need store part of yaml

class TaskManagerApp < Sinatra::Base #needs to inherit from sinatra to do get methods

  get '/' do
    erb :dashboard
  end

  get '/tasks' do
    @tasks = task_manager.all
    erb :index
  end

  get '/tasks/new' do
    erb :new
  end

  post '/tasks' do
    task_manager.create(params[:task])
    redirect '/tasks'
    # sending response back at a specific location, get to /tasks
  end

  get "/tasks/:id/edit" do |id| #or can use params[:edit]
    @task= task_manager.find(id.to_i)
    erb :edit
  end

  put "/tasks/:id" do |id|
    task_manager.update(params[:task], id.to_i)
    redirect "/tasks"
  end

  delete "/tasks/:id" do |id|
    task_manager.delete(id.to_i)
    redirect '/tasks'
  end

  not_found do
    erb :error #method call
  end

  get '/tasks/:id' do |id|
    @task = task_manager.find(id.to_i)
    erb :show
  end

  def task_manager
    database = YAML::Store.new('db/task_manager') #how you manipulate yaml file
    @task_manager ||= TaskManager.new(database) #makes a new instance var if not already there
  end

end
