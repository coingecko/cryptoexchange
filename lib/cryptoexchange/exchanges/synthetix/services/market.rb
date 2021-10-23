module Cryptoexchange::Exchanges
  module Synthetix
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
          "#{Cryptoexchange::Exchanges::Synthetix::Market::API_URL}/ticker/#{market_pair.base}-#{market_pair.target}"
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Synthetix::Market::NAME
          ticker.ask       = NumericHelper.to_d(output['ask'])
          ticker.bid       = NumericHelper.to_d(output['bid'])
          ticker.last      = NumericHelper.to_d(output['rate'])
          ticker.low      = NumericHelper.to_d(output['low24hRate'])
          ticker.high      = NumericHelper.to_d(output['high24hRate'])
          ticker.volume    = NumericHelper.to_d(output['volume24hFrom'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
