require 'rubygems'
require 'bundler'

Bundler.require

post '/' do
  content_type :json
  a = JSON.parse(request.body.read)
  if a.is_a?(Array)
    return a.inject(0) { |s, x| s+x}.to_s
  else
    status 404
    return {error: 'Invalid input'}.to_json
  end
end
