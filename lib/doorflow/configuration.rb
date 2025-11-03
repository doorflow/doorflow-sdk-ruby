module DoorFlow
  class Configuration
    attr_accessor :api_key, :api_base, :timeout, :open_timeout

    def initialize
      @api_base = 'https://api.doorflow.com'
      @timeout = 80
      @open_timeout = 30
    end
  end
end
