require 'twitter'

client = Twitter::REST::Client.new do |config|
  config.consumer_key = 'UJ5xCw7fUNnBFiUBfO68miUOl'
  config.consumer_secret = 'aRbwwwO4C01TTWn6qqOHxoB4Uh0otpvKo2TjY89kSHN5KGDKF2'
  config.access_token = '3329109672-5YSpidw0aLSDyMQqn6ZpcJDJMNLSf85xOp6LMHH'
  config.access_token_secret = 'fY48w7P852AjKUi6ZfAhBkQAYnf1mBm36GqcoXbmCO4xS'
end

SCHEDULER.every '10s', :first_in => 0 do |job|
  begin
    tweets = client.search("from:tb_messages", :result_type => "recent").each.map do |tweet|
      { name: tweet.text, body: tweet.user.screen_name }
    end
    send_event('twitter_mentions', comments: tweets)
  rescue
  end
end