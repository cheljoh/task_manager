require_relative '../test_helper'

class TaskTest < Minitest::Test
  def test_task_attributes_assigned_correctly
    data = { #setup
      "id" => 1,
      "title" => "my task",
      "description" => "something"
    }
    task = Task.new(data) #execution
    assert_equal 1, task.id #assertions
    assert_equal "my task", task.title
    assert_equal "something", task.description
    #no tear down
  end

end
