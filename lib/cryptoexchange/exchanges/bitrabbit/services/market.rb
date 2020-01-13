module Cryptoexchange::Exchanges
  module Bitrabbit
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          output = super(ticker_url)
          adapt_all(output)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Bitrabbit::Market::API_URL}/markets"
        end

        def adapt_all(output)
          output.map do |ticker|
            base, target = ticker["name"].split("/")

            market_pair = Cryptoexchange::Models::MarketPair.new(
                            base:   base,
                            target: target,
                            market: Bitrabbit::Market::NAME
                          )
            adapt(ticker["ticker"], market_pair)
          end.compact
        end

        def adapt(output, pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = pair.base
          ticker.target    = pair.target
          ticker.market    = Bitrabbit::Market::NAME
          ticker.last      = NumericHelper.to_d(output['last'])
          ticker.bid       = NumericHelper.to_d(output['buy'])
          ticker.ask       = NumericHelper.to_d(output['sell']) # ask is higher
          ticker.high      = NumericHelper.to_d(output['high'])
          ticker.low       = NumericHelper.to_d(output['low'])
          ticker.volume    = NumericHelper.to_d(output['volume'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
