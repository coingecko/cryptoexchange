module Cryptoexchange::Exchanges
  module Huulk
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
          "#{Cryptoexchange::Exchanges::Huulk::Market::API_URL}/#{market_pair.base.downcase}-#{market_pair.target.downcase}/ticker/"
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Huulk::Market::NAME
          ticker.last      = NumericHelper.to_d(output['price']['last'])
          ticker.high      = NumericHelper.to_d(output['price']['high'])
          ticker.low       = NumericHelper.to_d(output['price']['low'])
          ticker.bid       = NumericHelper.to_d(output['price']['best_bid'])
          ticker.ask       = NumericHelper.to_d(output['price']['best_ask'])
          ticker.volume    = NumericHelper.to_d(output['volume']['24h'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
