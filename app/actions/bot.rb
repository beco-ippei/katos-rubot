bot = SlackBot.instance

bot.hear :ambient, /hello/i do |msg|
  msg.reply "hello. I'm #{bot.user}." +
    " you are #{msg.user} in #{msg.channel}"
end

bot.hear :ambient, /bot hi/ do |msg|
  msg.reply "Hi <@#{msg.user}>!"
end

bot.hear :dm, /time/ do |msg|
  msg.reply "It's #{Time.now}"
  false
end

bot.hear :dm, /.*/ do |msg|
  msg.reply "Sorry <@#{msg.user}>, what?"
end

bot.hear :dm, /shutdown/ do |msg|
  msg.reply "ok. I'm shutting down ....\nBye!"
  bot.stop
end
