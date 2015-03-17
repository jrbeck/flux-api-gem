require 'simplecov'

SimpleCov.start

require 'rspec'
require 'webmock/rspec'
require 'json'
require 'flux'
require 'active_support/core_ext/hash'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

WebMock.disable_net_connect!

def mock_id_token_request
  stub_request(:post, "https://flux_app_id:flux_app_secret@id.fluxhq.io/oauth/token").
    with(:body => {"grant_type"=>"client_credentials"}).
    to_return(:status => 200, :body => '{"access_token":"abc123","token_type":"bearer","expires_in":7200,"scope":"public"}', :headers => { 'Content-Type' => 'application/json' })
end