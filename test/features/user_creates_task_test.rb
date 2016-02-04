require_relative '../test_helper'

#need to make git ignore for tmp

class UserCreatesTaskTest< Minitest::Test
  include Capybara::DSL
  include TestHelpers #teardown db after you test

  def test_with_valid_attributes
    #as a user, from home page, I click on "new task" i fill in title, description, and click submit
    visit '/'
      click_link("New Task")
      fill_in("task[title]", with: "hello")
      fill_in("task[description]", with: "Do something")
      click_button("Submit")

      assert_equal "/tasks", current_path
      
    within("#tasks") do
      assert page.has_content?("hello")
    end
  end

end
