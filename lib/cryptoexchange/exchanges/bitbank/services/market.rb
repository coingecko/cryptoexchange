module Cryptoexchange::Exchanges
  module Bitbank
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output,market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Bitbank::Market::API_URL}/#{market_pair.base.downcase}_#{market_pair.target.downcase}/ticker"
        end

        def adapt(output,market_pair)
          market = output['data']

          ticker           = Cryptoexchange::Models::Ticker.new

          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Bitbank::Market::NAME
          ticker.ask       = NumericHelper.to_d(market['sell'])
          ticker.bid       = NumericHelper.to_d(market['buy'])
          ticker.last      = NumericHelper.to_d(market['last'])
          ticker.high      = NumericHelper.to_d(market['high'])
          ticker.low       = NumericHelper.to_d(market['low'])
          ticker.volume    = NumericHelper.to_d(market['vol'])
          ticker.timestamp = market['timestamp'].to_i / 1000
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
