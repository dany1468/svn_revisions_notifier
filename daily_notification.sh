#!/bin/bash

webhookurl=$SLACK_WEBHOOK_URL

TITLE=$(echo "Yeterday revisions `date +"%Y-%m-%d" -d -1days` - `date "+%Y-%m-%d"`")
DAILY_SVN_LOG=$(svn log -r {"`date "+%Y-%m-%d" -d -1days`"}:{"`date "+%Y-%m-%d"`"} --username $SVN_USER --password $SVN_PASS -v $SVN_REPO_URL)

payload="payload={
  \"blocks\":[
    {
      \"type\":\"section\",
      \"text\": {
        \"type\":\"mrkdwn\",
        \"text\":\"$TITLE\"
      }
    },
    {
      \"type\": \"divider\"
    },
    {
      \"type\":\"section\",
      \"text\": {
        \"type\":\"mrkdwn\",
        \"text\": \"$DAILY_SVN_LOG\"
      }
    }
  ]
}"

curl -m 5 --data-urlencode "${payload}" "${webhookurl}"
