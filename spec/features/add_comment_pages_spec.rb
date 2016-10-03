require 'rails_helper'
require 'database_cleaner'

def user_log_in
  DatabaseCleaner.clean
  user = FactoryGirl.create(:user)
  visit '/'
  click_on "Sign In"
  fill_in "Email", :with => "new@gmail.com"
  fill_in "Password", :with => "password"
  click_on "Log in"
end

def create_post
  user = FactoryGirl.create(:user)
  login_as(user)
  visit posts_path
  click_on "New Post"
  fill_in "Text", :with => "something funny"
  click_on "Create Post"
end

describe 'Comments' do
  it 'validates adding a comment', js: true do
    create_post
    visit posts_path
    click_on "something funny"
    save_and_open_screenshot
    click_on "Add a comment"
    fill_in "Text", :with => "new comment"
    click_on "Create Comment"
    expect(page).to have_content("new comment")
  end
end
