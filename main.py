import tweepy
import config

auth = tweepy.OAuthHandler(config.COMSUMER_KEY, config.COMSUMER_SECRET)
auth.set_access_token(config.ACCESS_TOKEN, config.ACCESS_SECRET)

api = tweepy.API(auth)

public_tweets = api.home_timeline()
for tweet in public_tweets:
    print(tweet.text)
