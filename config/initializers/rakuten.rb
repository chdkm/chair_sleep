RakutenWebService.configure do |c|
  c.application_id = ENV.fetch('RAKUTEN_APP_ID', 'default_app_id')
end