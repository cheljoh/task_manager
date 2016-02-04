require_relative '../test_helper'

class HomePageGreetingTest < Minitest::Test
  include Capybara::DSL #gives access to vitis
  def test_home_page_welcomes_user
    #as a user, when i open the task manager page, i expect some kind of greeting- 'welcome to the task manager'
    visit '/'
    save_and_open_page
    within("#greeting") do #has to be string
      assert page.has_content?("Welcome to the Task Manager")
    end
  end

end
