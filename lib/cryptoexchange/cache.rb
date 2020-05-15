module Cryptoexchange
  class Cache
    attr_accessor :cache_instance

    def self.ticker_cache
      @@ticker_cache ||= new
    end

    def initialize
      @cache_instance ||= if Cryptoexchange.configuration.rails_cache
        Rails.cache
      else
        LruTtlCache.ticker_cache
      end

      @fetch_method ||= if Cryptoexchange.configuration.rails_cache
        :fetch
      else
        :getset
      end
    end

    def fetch(cache_key, **args, &block)
      if @cache_instance.class.ancestors.to_s.include? "ActiveSupport::Cache::Store"
        @cache_instance.send(@fetch_method, cache_key, { expires_in: Cryptoexchange.configuration.ticker_ttl }) do
          block.call
        end
      else
        @cache_instance.send(@fetch_method, cache_key) do
          block.call
        end
      end
    end

    def delete(cache_key)
      if @cache_instance.class.ancestors.to_s.include? "ActiveSupport::Cache::Store"
        @cache_instance.send(:delete, cache_key, { expires_in: Cryptoexchange.configuration.ticker_ttl }) do
          block.call
        end
      else
        @cache_instance.send(:delete, cache_key) do
          block.call
        end
      end
    end
  end
end
