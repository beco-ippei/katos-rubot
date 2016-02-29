bot = SlackBot.instance

IRKIT_SCRIPT = ENV['IRKIT_SCRIPT']
def irkit_cmd(swith)
  puts "aircon turn #{switch}"
  %x[#{IRKIT_SCRIPT} #{switch}]
end

bot.hear :dm, /air (on|off)/ do |msg|
  switch = msg.match[1]
  msg.reply "aircon turn #{switch}"
  irkit_cmd switch
end

bot.hear :ambient, /[えエ](お|オ|ふ|フ)/ do |msg|
  switch = if /[おオ]/ =~ msg.match[1]
             'on'
           else
             'off'
           end
  msg.reply "aircon turn #{switch}"
  irkit_cmd switch
end
