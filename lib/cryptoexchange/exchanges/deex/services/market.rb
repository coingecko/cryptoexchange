module Cryptoexchange::Exchanges
  module Deex
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
          base = market_pair.base
          target = market_pair.target
          "#{Cryptoexchange::Exchanges::Deex::Market::API_URL}/get_market_data/#{base}/#{target}/"
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Deex::Market::NAME
          ticker.bid       = NumericHelper.to_d(output['highest_bid'])
          ticker.ask       = NumericHelper.to_d(output['lowest_ask'])
          ticker.last      = NumericHelper.to_d(output['latest'])
          ticker.volume    = NumericHelper.to_d(output['base_volume'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
