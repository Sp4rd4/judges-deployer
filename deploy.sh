#!/bin/bash
curl -H "X-StewardToken: STEWARD_TOKEN" https://steward.io/j/STEWARD_JOB/start

cd /judges && git pull https://github.com/automaidan/judges.git && \
cd scraper && npm install && npm run scrap && \
git add . && git commit -m "Rescrap" && \
cd .. &&  npm run deploy:frontend

if [ $? -eq 0 ]; then
  curl -H "X-StewardToken: STEWARD_TOKEN" https://steward.io/j/STEWARD_JOB/end
else
  curl -H "X-StewardToken: STEWARD_TOKEN" https://steward.io/j/STEWARD_JOB/failed
fi
