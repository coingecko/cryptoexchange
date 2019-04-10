module Cryptoexchange
  class << self
    attr_accessor :configuration

    def configure
      self.configuration ||= Configuration.new
      yield(configuration)
    end

    def reset_config
      self.configuration = Configuration.new
    end
  end
end

class Configuration
  attr_accessor :rails_cache, :ticker_ttl, :cache_size

  def initialize
    @rails_cache = false
    @ticker_ttl = 10
    @cache_size = 200
  end
end
