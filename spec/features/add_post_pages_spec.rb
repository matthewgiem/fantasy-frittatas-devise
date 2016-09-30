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

describe 'Posts' do
  it "validates loggin" do
    user_log_in
    expect(page).to have_content "home page for post"
  end

  it 'validates adding a post' do
    user_log_in
    click_on "New Post"
    expect(page).to have_content 'Text'
  end

  it "creates a new post and adds it to the list", js: true do
    user = FactoryGirl.create(:user)
    login_as(user)
    visit posts_path
    click_on "New Post"
    fill_in "Text", :with => "something funny"
    save_and_open_screenshot
    click_on "Create Post"
    expect(page).to have_content("something funny")
  end
end
