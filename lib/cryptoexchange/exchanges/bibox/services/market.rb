module Cryptoexchange::Exchanges
  module Bibox
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
          "#{Cryptoexchange::Exchanges::Bibox::Market::API_URL}/mdata?cmd=ticker&pair=#{base}_#{target}"
        end

        def adapt(output, market_pair)
          market = output['result']
          ticker = Cryptoexchange::Models::Ticker.new

          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Bibox::Market::NAME
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
