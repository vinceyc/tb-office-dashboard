@echo off
echo Enter Channel Name
setlocal
set /p channel=
curl -d {"""auth_token""":"""YOUR_AUTH_TOKEN""","""channel""":"""%channel%"""} http://host:3030/widgets/twitch