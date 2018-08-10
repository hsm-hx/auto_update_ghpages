require 'twitter'
require './secret.rb'

class Bot
  attr_accessor :client

  def initialize
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = CONSUMER_KEY
      config.consumer_secret = CONSUMER_SECRET
      config.access_token= OAUTH_TOKEN
      config.access_token_secret= OAUTH_SECRET
    end
  end

  def post(text = "", twitter_id:nil, status_id:nil)
    if status_id
      rep_text = "@#{twitter_id} #{text}"
      @client.update(rep_text, {:in_reply_to_status_id => status_id})
      puts "#{text}"
    else
      @client.update(text)
      puts "#{text}"
    end
  end

  def fav(status_id:nil)
    if status_id
      @client.favorite(status_id)
    end
  end

  def retweets(status_id:nil)
    if status_id
      @client.retweet(status_id)
    end
  end

  def get_recently_tweet(user_name, tweet_count)
    tweets = Array[]
    @client.user_timeline(
      user_name, {count: tweet_count}
    ).each do |timeline|
      tweets[tweets.length] = @client.status(timeline.id)
    end
  end

  def get_search(word, tweet_count)
    tweets = Array[]
    @client.search(word).take(tweet_count).each do 
      |timeline|
      tweets[tweets.length] = @client.status(timeline.id)
    end
  end

  def show_tweets(timeline)
    timeline.each do |timeline|
      tweet = @client.status(timeline.id)
      puts tweet.created_at
      puts tweet.text
    end
  end
end

bot = Bot.new
bot.show_tweets(bot.get_search("#はすみめも", 10))
