module Cryptoexchange::Exchanges
  module BiboxFutures
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
          "#{Cryptoexchange::Exchanges::BiboxFutures::Market::API_URL}/mdata?cmd=market&pair=#{market_pair.inst_id}"
        end

        def adapt(output, market_pair)
          market = output['result']
          ticker = Cryptoexchange::Models::Ticker.new

          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = BiboxFutures::Market::NAME
          ticker.last      = NumericHelper.to_d(market['last'])
          ticker.high      = NumericHelper.to_d(market['high'])
          ticker.low       = NumericHelper.to_d(market['low'])
          ticker.volume    = NumericHelper.to_d(market['vol24H'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
