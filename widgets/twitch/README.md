Description
===========
A Dashing widget to add live twitch streams to your dashboard.

Note that this is not really a productive widget (unless you are a streamer, I suppose). Our's is in the break room with weather and news widgets.

![](http://i.imgur.com/nJGtrYNm.png)

Usage
=====

Make a folder called 'twitch' in your widgets directory. Add twitch.html and twitch.coffee to the twitch folder.

Add the widget HTML to your dashboard
```
    <li data-row="1" data-col="1" data-sizex="3" data-sizey="2">
        <div data-id="twitch" data-view="Twitch"></div>
    </li>
```

Use the following to switch channels:
````
curl -d '{ "auth_token": "YOUR_AUTH_TOKEN", "channel": "CHANNELNAME" }' \http://host:3030/widgets/twitch
curl -d '{ "auth_token": "4lnbdxswl9j8y439q6mcdhd59anrec", "channel": "vinceyc" }' \http://localhost
curl -d '{ "auth_token": "live_102870196_m3hu8W07EAFvN0DVPJuQZMAIiOOj5T", "channel": "vinceyc" }' \http://host:3030/widgets/twitch
````

if you have curl for windows in your path, you can use the batch file to make it easy!

https://api.twitch.tv/kraken/oauth2/authorize
    ?response_type=code
    &client_id=[lcvv834nxvx0x4e6d7n8smca0bg2jbe]
    &redirect_uri=[http://localhost]
    &scope=[space separated list of scopes]
    &state=[your provided unique token]