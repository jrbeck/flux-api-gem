require 'spec_helper'

describe Flux::Application do
  before{ mock_id_token_request }
  subject{ Flux::Client.new('flux_app_id', 'flux_app_secret', 'metova').application }

  describe '#initialize' do
    it 'should assign the token' do
      expect(subject.flux_token).to be_a OAuth2::AccessToken
      expect(subject.flux_token.token).to eq 'abc123'
    end
  end
end