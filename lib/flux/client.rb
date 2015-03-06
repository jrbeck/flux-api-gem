require 'oauth2'

module Flux
  class Client
    def initialize(flux_id, flux_secret, domain, options={})
      default_options = {
        api_version: '3',
        server_url: "https://#{domain}.fluxhq.io",
        auth_url: 'https://id.fluxhq.io'
      }
      @flux_id = flux_id
      @flux_secret = flux_secret
      @domain = domain

      @options = default_options.merge options
    end

    def user(token)
      Flux::User.new flux_token(token), @options
    end

    def application
      Flux::Application.new flux_token(id_token.token), @options
    end

    def flux_id
      @flux_id
    end

    def flux_secret
      @flux_secret
    end

    def domain
      @domain
    end

    def options
      @options
    end

    protected

    def id_client
      @id_client ||= OAuth2::Client.new(@flux_id, @flux_secret, site: @options[:auth_url])
    end

    def flux_client
      @flux_client ||= OAuth2::Client.new(nil, nil, site: @options[:server_url])
    end

    def id_token
      @id_token ||= id_client.client_credentials.get_token
    end

    def flux_token(token=nil)
      if token
        if token.is_a?(Hash)
          @flux_token = OAuth2::AccessToken.new flux_client, token['token'], { header_format: 'Token %s' }.merge(token.tap{ |t| t.delete('token'); t.delete('expires') })
        else
          @flux_token = OAuth2::AccessToken.new flux_client, token, { header_format: 'Token %s' }
        end
      else
        @flux_token
      end
    end
  end
end