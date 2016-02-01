require 'slack-bot-slim'

SlackBot.token = ENV['SLACK_BOT_TOKEN']
bot = SlackBot.instance

$LOAD_PATH.unshift File.expand_path('../app', __FILE__)

require 'application'

# start
bot.start

