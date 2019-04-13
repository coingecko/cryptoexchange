class LruTtlCache
  class << self
    def ticker_cache
      @@ticker_cache ||= LruRedux::TTL::Cache.new(
        Cryptoexchange.configuration.cache_size,
        Cryptoexchange.configuration.ticker_ttl
      )
    end
  end
end
