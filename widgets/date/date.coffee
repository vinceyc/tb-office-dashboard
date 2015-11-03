class Dashing.Date extends Dashing.Widget

  ready: ->
    setInterval(@startTime, 500)

  startTime: =>
    today = new Date()

    day = today.getDay()
    month = today.getMonth()
    year = today.getFullYear()

    @set('date', day + " / " + month + " / " + year)