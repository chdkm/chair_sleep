RakutenWebService.configure do |c|
  c.application_id = ENV.fetch['RAKUTEN_API_KEY']
end