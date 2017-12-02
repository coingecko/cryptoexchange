require 'bigdecimal'

module Cryptoexchange::Exchanges
  module CoinExchange
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          unless @market_id_cache
            output = super(pairs_url)
            hydrate_market_id_cache(output)
          end

          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def pairs_url
          "#{Cryptoexchange::Exchanges::CoinExchange::Market::API_URL}/getmarkets"
        end

        def ticker_url(market_pair)
          id = market_id(market_pair)
          "#{Cryptoexchange::Exchanges::CoinExchange::Market::API_URL}/getmarketsummary?market_id=#{id}"
        end

        def adapt(output, market_pair)
          market = output['result']

          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = CoinExchange::Market::NAME
          ticker.last      = NumericHelper.to_d(market['LastPrice'])
          ticker.bid       = NumericHelper.to_d(market['BidPrice'])
          ticker.ask       = NumericHelper.to_d(market['AskPrice'])
          ticker.high      = NumericHelper.to_d(market['HighPrice'])
          ticker.low       = NumericHelper.to_d(market['LowPrice'])
          ticker.volume    = NumericHelper.divide(NumericHelper.to_d(market['Volume']), ticker.last)
          ticker.timestamp = Time.now.to_i
          ticker.payload   = market
          ticker
        end

        private

        def market_id_cache_key(market_pair)
          "#{market_pair.base}_#{market_pair.target}"
        end

        def hydrate_market_id_cache(output)
          @market_id_cache = {}
          output['result'].each do |market|
            key = "#{market['MarketAssetCode']}_#{market['BaseCurrencyCode']}"
            @market_id_cache[key] = market['MarketID']
          end
        end

        def market_id(market_pair)
          @market_id_cache[market_id_cache_key(market_pair)]
        end
      end
    end
  end
end
