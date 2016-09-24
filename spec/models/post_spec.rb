require 'rails_helper'

describe Post do
  it { should validate_presence_of :text }
  it { should belong_to(:user) }
end
