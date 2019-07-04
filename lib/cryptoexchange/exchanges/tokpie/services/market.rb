module Cryptoexchange::Exchanges
  module Tokpie
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          ctx = OpenSSL::SSL::SSLContext.new
          ctx.verify_mode = OpenSSL::SSL::VERIFY_NONE

          output = Cryptoexchange::Cache.ticker_cache.fetch(ticker_url(market_pair)) do
            HTTP.get(ticker_url(market_pair), ssl_context: ctx).parse(:json)
          end
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Tokpie::Market::API_URL}/api_ticker/?market=#{market_pair.base.upcase}@#{market_pair.target.upcase}"
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Tokpie::Market::NAME
          ticker.last      = NumericHelper.to_d(output['result']['last'])
          ticker.high      = NumericHelper.to_d(output['result']['high24hr'])
          ticker.low       = NumericHelper.to_d(output['result']['low24hr'])
          ticker.bid       = NumericHelper.to_d(output['result']['highestBid'])
          ticker.ask       = NumericHelper.to_d(output['result']['lowestAsk'])
          ticker.change    = NumericHelper.to_d(output['result']['percentChange'])
          ticker.volume    = NumericHelper.to_d(output['result']['baseVolume'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
