class LruTtlCache
  class << self
    def ticker_cache(ticker_ttl = 10)
      @@ticker_cache ||= LruRedux::TTL::Cache.new(100, ticker_ttl)
    end

    def token_cache(token_ttl = 6000)
      @@token_cache ||= LruRedux::TTL::Cache.new(500, token_ttl)
    end
  end
end
