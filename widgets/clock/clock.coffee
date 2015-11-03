class Dashing.Clock extends Dashing.Widget

  ready: ->
    setInterval(@startTime, 500)

  startTime: =>
    today = new Date()

    day = today.getDate()
    weekday = today.getDay()
    month = today.getMonth()
    year = today.getFullYear()

    days = [
      "Sunday",
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday"
    ]
    months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ]

    monthyear =  months[month] + ' ' + year
    dayofweek = days[weekday] + ' ' + day

    @set('weekday', days[weekday])
    @set('day', dayofweek)
    @set('monthyear', monthyear)