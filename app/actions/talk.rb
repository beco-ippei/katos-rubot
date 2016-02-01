require 'docomo-api'

dlg = DocomoAPI::Dialogue.new ENV['DOCOMO_API_KEY']
bot = SlackBot.instance

bot.hear :dm, /(.*)/ do |msg|
  res = dlg.talk msg.text
  msg.reply res
end

