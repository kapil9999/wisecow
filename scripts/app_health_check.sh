#!/bin/bash

APP_URL="http://localhost:4499"

HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" $APP_URL)

if [ "$HTTP_STATUS" -eq 200 ]; then
  echo "Application is UP (HTTP $HTTP_STATUS)"
else
  echo "Application is DOWN (HTTP $HTTP_STATUS)"
fi

