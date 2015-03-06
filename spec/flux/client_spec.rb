require 'spec_helper'

describe Flux::Client do
  subject do
    Flux::Client.new('flux_app_id', 'flux_app_secret', 'metova')
  end

  describe '#initialize' do
    it 'assigns the id, secret, and domain' do
      expect(subject.flux_id).to eq 'flux_app_id'
      expect(subject.flux_secret).to eq 'flux_app_secret'
      expect(subject.domain).to eq 'metova'
    end
  end

  describe '#user' do
    it 'sets up a new user with the token' do
      user = subject.user('abc123')
      expect(user).to be_a Flux::User
      expect(user.flux_token.token).to eq 'abc123'
    end
  end

  describe '#application' do
    before do
      mock_id_token_request
    end

    it 'sets up a new user using the app token' do
      app = subject.application
      expect(app).to be_a Flux::Application
      expect(app.flux_token.token).to eq 'abc123'
    end
  end

  describe '#id_client' do
    it 'sets up the fluxid client' do
      client = subject.send(:id_client)
      expect(client).to be_a OAuth2::Client
      expect(client.id).to eq 'flux_app_id'
      expect(client.secret).to eq 'flux_app_secret'
      expect(client.site).to eq subject.options[:auth_url]
    end
  end

  describe '#id_token' do
    before { mock_id_token_request }
    it 'gets the id token' do
      id_token = subject.send(:id_token)
      expect(id_token).to be_a OAuth2::AccessToken
      expect(id_token.token).to eq 'abc123'
    end
  end

  describe '#flux_client' do
    it 'sets up the flux client' do
      client = subject.send(:flux_client)
      expect(client).to be_a OAuth2::Client
      expect(client.id).to eq nil
      expect(client.secret).to eq nil
      expect(client.site).to eq subject.options[:server_url]
    end
  end

  describe '#flux_token' do
    it 'when passed a token, sets up a flux token' do
      token = subject.send(:flux_token, 'abc123')
      expect(token).to be_a OAuth2::AccessToken
      expect(token.token).to eq 'abc123'
      expect(token.client).to eq subject.send(:flux_client)
    end

    it 'when passed a token hash, sets up a flux token' do
      token = subject.send(:flux_token, { 'token' => 'abc123', 'refresh_token' => 'def456', 'expires_at' => 123456 })
      expect(token).to be_a OAuth2::AccessToken
      expect(token.token).to eq 'abc123'
      expect(token.refresh_token).to eq 'def456'
      expect(token.expires_at).to eq 123456
      expect(token.client).to eq subject.send(:flux_client)
    end
  end
end