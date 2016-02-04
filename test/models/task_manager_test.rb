require_relative '../test_helper'

class TaskManagerTest < Minitest::Test
  include TestHelpers

  def test_can_create_a_task
    data = {
      title: "some title",
      description: "some description"
    }
    task_manager.create(data)

    task=task_manager.all.last #get last item in array
    assert task.id
    assert_equal "some title", task.title
    assert_equal "some description", task.description
    #will delete db afterwards
  end

  def test_all
    data1 = {
      id: "1",
      title: "some title",
      description: "some description"}
    data2 = {
      id: "2",
      title: "get food",
      description: "lots of it"}
    task_manager.create(data1)
    task_manager.create(data2)
    assert_equal 2, task_manager.all.length
    assert_equal "get food", task_manager.all.last.title
  end

  def test_find
    data1 = {
      id: "1",
      title: "some title",
      description: "some description"}
    data2 = {
      id: "2",
      title: "get food",
      description: "lots of it"}
    task_manager.create(data1)
    task_manager.create(data2)
    task2 = task_manager.find(2)
    task1 = task_manager.find(1)
    assert_equal "lots of it", task2.description
    assert_equal "get food", task2.title
    assert_equal "some title", task1.title
    assert_equal "some description", task1.description
  end

  def test_update
    data = {
      id: 1,
      title: "some title",
      description: "some description"}
    task_manager.create(data)
    assert_equal "some title", task_manager.all.last.title
    updated_info = {
      "title"=>"get car", "description"=>"red one"
    }
    updated = task_manager.update(updated_info, 1)
    assert_equal "get car", task_manager.all.last.title
    assert_equal 1, task_manager.all.last.id
  end

  def test_delete
    data1 = {
      id: 1,
      title: "some title",
      description: "some description"}
    data2 = {
      id: 2,
      title: "get food",
      description: "yummy"}
    task_manager.create(data1)
    task_manager.create(data2)
    assert_equal "get food", task_manager.all.last.title
    expected = [{
      "id"=>2, "title"=>"get food", "description"=>"yummy"
    }]
    assert_equal expected, task_manager.delete(1)
  end

end
