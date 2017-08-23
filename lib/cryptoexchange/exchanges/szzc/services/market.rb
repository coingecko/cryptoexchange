module Cryptoexchange::Exchanges
  module Szzc
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Szzc::Market::API_URL}/ticker/#{market_pair.base}#{market_pair.target}"
        end

        def adapt(output, market_pair)
          result           = output['result']
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Szzc::Market::NAME
          ticker.ask       = NumericHelper.to_d(result['sell'] / 1e8)
          ticker.bid       = NumericHelper.to_d(result['buy'] / 1e8)
          ticker.last      = NumericHelper.to_d(result['last24h'] / 1e8)
          ticker.high      = NumericHelper.to_d(result['high24h'] / 1e8)
          ticker.low       = NumericHelper.to_d(result['low24h'] / 1e8)
          ticker.volume    = NumericHelper.to_d(result['vol24h'] / 1e8)
          ticker.timestamp = Time.now.to_i
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
