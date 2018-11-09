class LruTtlCache
  class << self
    def ticker_cache(ticker_ttl = 5, cache_size = 200)
      @@ticker_cache ||= LruRedux::TTL::Cache.new(cache_size, ticker_ttl)
    end
  end
end
