class Post < ActiveRecord::Base
  validates_presence_of :text
  belongs_to :user
  has_many :comments

  before_create :send_message
private

  def send_message
    begin
      message = RestClient::Request.new(
      :method => :post,
      :url => 'https://api.twilio.com/2010-04-01/Accounts/AC71a7982ab5d7a322a2cf3607cd05e8e2/Messages.json',
      :user => ENV['TWILIO_ACCOUNT_SID'],
      :password => ENV['TWILIO_AUTH_TOKEN'],
      :payload => { :Body => text,
                    :From => "4156104770 ",
                    :To => "4155900939" }
      ).execute
    rescue RestClient::BadRequest => error
      message = JSON.parse(error.response)["message"]
      errors.add(:base, message)
      throw(:abort)
    end
  end
end
