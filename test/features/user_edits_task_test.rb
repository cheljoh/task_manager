require_relative '../test_helper'

#need to make git ignore for tmp

class UserEditsTaskTest< Minitest::Test
  include Capybara::DSL
  include TestHelpers #teardown db after you test

  def test_edit_task
    #as a user, from home page, I click on "new task" i fill in title, description, and click submit
    data1 = {
      id: 1,
      title: "some title",
      description: "some description"}
    task_manager.create(data1)
    visit '/tasks/1/edit'
      fill_in("task[title]", with: "hello")
      fill_in("task[description]", with: "do things")
      click_button("Submit")

      assert_equal '/tasks', current_path

      visit '/tasks/1'
    
      within 'h1' do
        assert page.has_content?("hello")
      end

      within 'p' do
        assert page.has_content?("do things")
      end

  end

end
