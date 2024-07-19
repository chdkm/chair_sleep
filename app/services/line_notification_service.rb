class LineNotificationService
  def initialize(user)
    @user = user
    @line_user_id = user.line_user_id
    @access_token = ENV.fetch('LINE_CHANNEL_TOKEN', nil)
  end

  def self.send_line_message(user, message)
    new(user).send_line_message(message)
  end

  def send_line_message(message)
    uri = URI.parse("https://api.line.me/v2/bot/message/push")
    request = Net::HTTP::Post.new(uri)
    request["Content-Type"] = "application/json"
    request["Authorization"] = "Bearer #{@access_token}"
    request.body = JSON.dump({
      "to" => @line_user_id,
      "messages" => [
        {
          "type" => "text",
          "text" => message
        }
      ]
    })

    Rails.logger.info "Sending LINE message to #{@line_user_id} with message: #{message}"

    req_options = {
      use_ssl: uri.scheme == "https"
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end

    Rails.logger.info "Received response: #{response.code} - #{response.body}"
    response
  end
end