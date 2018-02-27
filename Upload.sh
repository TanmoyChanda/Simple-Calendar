#!/bin/sh

# upload apk to hockey app

curl \

-F "ipa=@app/build/outputs/apk/*-release.apk" \
-H "X-HockeyAppToken: 3f26dfcf033146b2b1f9a14c09e574f7" \
https://rink.hockeyapp.net/manage/apps/704437/app_versions/upload
