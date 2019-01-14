module Cryptoexchange::Exchanges
  module Fourteenbit
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          output = super(self.ticker_url)
          adapt_all(output)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Fourteenbit::Market::API_URL}/market"
        end

        def adapt_all(output)
          output.map do |pair|
            base, target = pair['market'].split('/')
            market_pair = Cryptoexchange::Models::MarketPair.new(
                            base: base,
                            target: target,
                            market: Fourteenbit::Market::NAME
                          )
            adapt(pair, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Fourteenbit::Market::NAME
          ticker.timestamp = nil
          ticker.low       = NumericHelper.to_d(output['low'])
          ticker.high      = NumericHelper.to_d(output['high'])
          ticker.last      = NumericHelper.to_d(output['last'])
          ticker.bid       = NumericHelper.to_d(output['bid'])
          ticker.ask       = NumericHelper.to_d(output['ask'])         
          ticker.volume    = NumericHelper.to_d(output['volume24hr'])
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
