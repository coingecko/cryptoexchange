module Cryptoexchange::Exchanges
  module Bitmart
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          url = ticker_url(market_pair)
          output = super(url)
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Bitmart::Market::API_URL}/ticker/#{market_pair.base}_#{market_pair.target}"
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Bitmart::Market::NAME
          ticker.ask       = NumericHelper.to_d(output['ask_1'])
          ticker.bid       = NumericHelper.to_d(output['bid_1'])
          ticker.high      = NumericHelper.to_d(output['high_24h'])
          ticker.low       = NumericHelper.to_d(output['low_24h'])
          ticker.change    = NumericHelper.to_d(output['priceChange'])
          ticker.last      = NumericHelper.to_d(output['new_24h'])
          ticker.volume    = NumericHelper.to_d(output['volume'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
