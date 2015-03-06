module Flux
  class Application
    include Flux::ApiConcern

    def initialize(token, options={})
      @flux_token = token
      @options = options
    end
  end
end