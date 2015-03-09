module Flux
  module ApiConcern
    def users
      JSON.parse(flux_token.get("/api/users.json", request_headers).body).map(&:deep_symbolize_keys)
    end

    def accounts
      JSON.parse(flux_token.get("/api/accounts.json", request_headers).body).map(&:deep_symbolize_keys)
    end

    def products
      JSON.parse(flux_token.get("/api/products.json", request_headers).body).map(&:deep_symbolize_keys)
    end

    def projects
      JSON.parse(flux_token.get("/api/projects.json", request_headers).body).map(&:deep_symbolize_keys)
    end

    def account_links
      JSON.parse(flux_token.get("/api/account_links.json", request_headers).body).map(&:deep_symbolize_keys)
    end

    def metadata(ids)
      JSON.parse(flux_token.get("/api/projects/metadata.json?ids=#{ids.join(',')}", request_headers).body).map(&:deep_symbolize_keys)
    end

    def me
      JSON.parse(flux_token.get("/api/users/me.json", request_headers).body).deep_symbolize_keys
    end

    def request_headers
      { headers: { 'Accept' => "*/*,version=#{options[:api_version]}"} }
    end

    def options
      @options ||= Hash.new
    end

    def flux_token
      @flux_token = @flux_token.refresh! if @flux_token.expired?
      @flux_token
    end
  end
end