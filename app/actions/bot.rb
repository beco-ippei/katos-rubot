bot = SlackBot.instance

bot.hear :ambient, /hello/i do |msg|
  msg.reply "hello. I'm #{bot.user}." +
    " you are #{msg.user} in ##{msg.channel}"
end

bot.hear :mention, / *hi */i do |msg|
  msg.reply "Hi <@#{msg.user}>!"
end

bot.hear :dm, /time/ do |msg|
  msg.reply "It's #{Time.now}"
  false
end

bot.hear :dm, /test/ do |msg|
  msg.reply "'test' direct mentioned"
end

bot.hear :mention, /test/ do |msg|
  msg.reply "'test' mentioned"
end

bot.hear :dm, /shutdown/ do |msg|
  msg.reply "ok. I'm shutting down ....\nBye!"
  `touch ./stop`
  bot.stop
end
