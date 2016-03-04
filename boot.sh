#!/bin/bash

# default
if [ -f env.sh ];then
  source ./env.sh
fi

api="https://slack.com/api"
auth_api="${api}/auth.test?token=${SLACK_BOT_TOKEN}"
presence_api="${api}/users.getPresence?token=${SLACK_BOT_TOKEN}"

auth_info=`curl -s "${auth_api}"`
auth_status=`echo $auth_info | jq -r '.ok'`
if [ "${auth_status}" != "true" ]; then
  echo "auth failed."
  exit 1
fi

start_slackbot() {
  bundle exec bin/slackbot "--name=${PROCESS_NAME}" &
}

while true; do
  if [ -f ./stop ]; then
    echo "stopped by flag..."
    break
  fi
  #TODO: reboot.

  #TODO: move to checker
  pid=`pgrep -f "name=${PROCESS_NAME}"`
  if [ -z "${pid}" ];then
    start_slackbot
  else
    st=`curl -s "${presence_api}" | jq -r '.presence'`
    if [ "${st}" != "active" ]; then
      echo ""
      echo `date '+%Y-%m-%d %H:%M'`": inactive"
      echo "reboot skackbot."
      kill $pid
      start_slackbot
    else
      echo -n "-"
    fi
  fi
  sleep 60
done

