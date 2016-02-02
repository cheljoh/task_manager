require 'yaml/store' #just need store part of yaml
require_relative 'task'

class TaskManager
  attr_reader :database

  def initialize(database)
    @database = database
  end

  def create(task)
    database.transaction do
      database['tasks'] ||= [] #make sure its there or create empty array
      database['total'] ||= 0
      database['total'] += 1
      database['tasks'] << {"id" => database['total'], "title" => task[:title], "description" => task[:description] }
    end
  end

  def raw_tasks
    database.transaction do #make a new YAML store, transaction wraps in a block, way to access file
      database['tasks'] || []
    end
  end

  def update(task, id)
    database.transaction do
      target_task = database["tasks"].find {|task| task["id"] == id}
      target_task['title'] = task['title']
      target_task['description'] = task['description']
    end
  end

  def delete(id)
    database.transaction do
      database["tasks"].delete_if { |task| task["id"] == id }
    end
  end

  def raw_task(id)
    raw_tasks.find { |task| task["id"] == id}
  end

  def find(id)
    Task.new(raw_task(id))
  end

  def all
    raw_tasks.map {|data| Task.new(data)}
  end

end
