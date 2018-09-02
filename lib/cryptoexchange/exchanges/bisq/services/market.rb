module Cryptoexchange::Exchanges
  module Bisq
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
          base = market_pair.base.downcase
          target = market_pair.target.downcase
          "#{Cryptoexchange::Exchanges::Bisq::Market::API_URL}/ticker?market=#{base}_#{target}"
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Bisq::Market::NAME

          ticker.last      = NumericHelper.to_d(output.first['last'])
          ticker.high      = NumericHelper.to_d(output.first['high'])
          ticker.low       = NumericHelper.to_d(output.first['low'])
          ticker.volume    = NumericHelper.to_d(output.first['volume_left'])

          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
