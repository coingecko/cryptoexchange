class LruTtlCache
  class << self
    def ticker_cache(ticker_ttl = 10)
      @@ticker_cache ||= LruRedux::TTL::Cache.new(200, ticker_ttl)
    end
  end
end
