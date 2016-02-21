#!/bin/sh

if [ -f env.sh ];then
  source ./env.sh
fi

api="https://slack.com/api"
auth_api="${api}/auth.test?token=${SLACK_BOT_TOKEN}"
presence_api="${api}/users.getPresence?token=${SLACK_BOT_TOKEN}&user=${user_id}"

auth_info=`curl -s "${auth_api}"`
auth_status=`echo $auth_info | jq '.ok'`
if [ "${auth_status}" != "true" ]; then
  echo "auth failed."
  exit 1
fi
user_id=`echo $auth_info | jq '.user_id'`

start_slackbot() {
  bundle exec bin/slackbot --name=slackbot &
}

while true; do
  if [ -f stop ]; then
    echo "stopped by flag..."
    break
  fi

  pid=`pgrep -f 'name=slackbot'`
  if [ "${pid}" = "" ];then
    start_slackbot
  else
    st=`curl -s "${presence_api}" | jq '.presence'`
    if [ "${st}" != '"active"' ]; then
      echo ""
      echo `date '+%Y-%m-%d %H:%M'`": inactive"
      echo "reboot skackbot."
      kill $pid
      start_slackbot
    else
      echo -n "-"
    fi
  fi
  sleep 120
done

