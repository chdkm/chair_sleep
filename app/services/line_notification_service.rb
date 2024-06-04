require 'line/bot'
require 'rest-client'

class LineNotificationService
  def initialize(user)
    @user = user
    @line_user_id = user.line_user_id
    @access_token = ENV['LINE_CHANNEL_TOKEN']
  end

  def self.send_line_message(user,message)
    uri = URI.parse("https://api.line.me/v2/bot/message/push")
    request = Net::HTTP::Post.new(uri)
    request["Content-Type"] = "application/json"
    request["Authorization"] = "Bearer ENV['LINE_CHANNEL_TOKEN']"
    request.body = JSON.dump({
      "to" => @line_user_id,
      "messages" => [
        {
          "type" => "text",
          "text" => message
        }
      ]
    })

    req_options = {
      use_ssl: uri.scheme == "https"
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end
    response
  end
end