class Dashing.TwelveHourClock extends Dashing.Widget

  ready: ->
    setInterval(@startTime, 1000)

  startTime: =>
    today    = new Date()
    hours    = @getHours(today.getHours())
    minutes  = @formatTime(today.getMinutes())
    meridiem = @getMeridiem(today.getHours())
    @set('time', hours + ":" + minutes)
    @set('meridiem', meridiem)
    @set('date', today.toDateString())

  getHours: (i) ->
    ((i + 11) %% 12) + 1

  getMeridiem: (i) ->
    if i < 12 then "AM" else "PM"

  formatTime: (i) ->
    if i < 10 then "0" + i else i
