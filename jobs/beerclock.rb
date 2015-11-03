SCHEDULER.every '100s' do

    some_date = Date.today
    next_friday = some_date + (5 - some_date.cwday) % 7

    date = next_friday.to_s + ' ' + '15:00:00'

    send_event('beerclock', { end: date })
end