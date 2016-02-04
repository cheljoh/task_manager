require_relative '../test_helper'

#need to make git ignore for tmp

class UserDeletesTaskTest< Minitest::Test
  include Capybara::DSL
  include TestHelpers #teardown db after you test

  def test_user_deletes_one_task
    data1 = {
      id: 1,
      title: "some title",
      description: "some description"}
    task_manager.create(data1)
    id = task_manager.all.last.id
    visit '/tasks'
      click_button("Delete")
      assert_equal "/tasks", current_path
    within("#tasks") do
      refute page.has_content?("some title")
    end
  end

end
