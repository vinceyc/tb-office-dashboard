require 'google/api_client'
require 'google/api_client/client_secrets'
require 'google/api_client/auth/file_storage'
require 'google/api_client/auth/installed_app'
require 'google_drive'

WORKSHEET_NUMBER = 0 # zero start
CELLS_ROW_NUMBER = 1
CELLS_COLUMN_NUMBER = 1

def authorize
  client = Google::APIClient.new(
    :application_name => 'Google SpreadSheet for Dashing',
    :application_version => '1.0.0')

  file_storage = Google::APIClient::FileStorage.new('credential-oauth2.json')
  if file_storage.authorization.nil?
    flow = Google::APIClient::InstalledAppFlow.new(
      :client_id => '649743256362-3sdsoc1hdou2tohs8ap6ffc1v2v1b1j8.apps.googleusercontent.com',
      :client_secret => 'snzCtFXfsYuXbGkjSYVzMQri',
      :scope => %w(
        https://www.googleapis.com/auth/drive
        https://docs.google.com/feeds/
        https://docs.googleusercontent.com/
        https://spreadsheets.google.com/feeds/
      ),
    )
    client.authorization = flow.authorize(file_storage)
  else
    client.authorization = file_storage.authorization
  end

  client
end

WORKSHEET_ROWS = 7

ongoingPitches = Hash.new({ value: 0 })
ongoingPitchesCol = 1
ongoingPitchesStatusesCol = 2

leaderboard = Array.new
leaderboardCol = 3
leaderboardScoreCol = 4

ongoingProjects = Hash.new({ value: 0 })
ongoingProjectsCol = 5
ongoingProjectsProgressCol = 6

HeaderCol = 7

SCHEDULER.every '15s', :first_in => 0 do |job|
  client = authorize
  session = GoogleDrive.login_with_oauth(client.authorization.access_token)
  ws = session.spreadsheet_by_key('1JcufCLGj6IUplrEyhuVNvE5NbSI3XvyJSe5w2p7GmW8').worksheets[WORKSHEET_NUMBER]

  $i = 0
  begin
      ongoingPitches[$i] = {
        label:  ws[($i+2), ongoingPitchesCol],
        status: ws[($i+2), ongoingPitchesStatusesCol]
      }
     $i +=1
     $value = ws[($i+2), ongoingPitchesCol]
  end while $value.to_s.strip.length > 0

  $p = 0
  begin
      ongoingProjects[$p] = {
        name:  ws[($p+2), ongoingProjectsCol],
        progress: ws[($p+2), ongoingProjectsProgressCol]
      }
     $p +=1
     $project = ws[($p+2), ongoingProjectsCol]
  end while $project.to_s.strip.length > 0

  $l = 0
  leaderboard = Array.new
  begin
      leaderboard.push([ ws[($l+2), leaderboardScoreCol].to_i, ws[($l+2), leaderboardCol] ])

      $l +=1
      $leader = ws[($l+2), leaderboardCol]
  end while $leader.to_s.strip.length > 0

  leaderboard_sorted = leaderboard.sort { |a,b| b <=> a }

  send_event('progress_bars', { title: 'Projects Progress', progress_items: ongoingProjects.values })
  send_event('ongoingpitches', { items: ongoingPitches.values })
  send_event('leaderboard', { items: leaderboard_sorted })

  cell_value = ws[CELLS_ROW_NUMBER, CELLS_COLUMN_NUMBER]
  notice1 = ws[2, HeaderCol]
  notice2 = ws[3, HeaderCol]
  emojicon = ws[4, HeaderCol]
  pic = ws[3, 8]
  pic_caption = ws[2, 8]
  caption = ws[2, 9]
  caption_image = ws[3, 9]
  send_event('google_spreadsheet', { value: cell_value })
  send_event('notice1', { text: notice1 })
  send_event('notice2', { text: notice2 })
  send_event('emojicon', { text: emojicon })
  send_event('pic', { image: pic, text: pic_caption })
  send_event('caption', { image: caption_image, text: caption })
end