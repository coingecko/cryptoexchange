module Cryptoexchange::Exchanges
  module Birake
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
          "#{Cryptoexchange::Exchanges::Birake::Market::API_URL}/public/ticker"
        end

        def adapt_all(output)
          output.map do |ticker|
            market_pair = Cryptoexchange::Models::MarketPair.new({
              base: ticker['quote'],
              target: ticker['base'],
              market: Birake::Market::NAME
            })
            adapt(market_pair, ticker)
          end.compact
        end

        def adapt(market_pair, output)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Birake::Market::NAME
          ticker.last      = NumericHelper.to_d(output['latest'])
          ticker.bid       = NumericHelper.to_d(output['highest_bid'])
          ticker.ask       = NumericHelper.to_d(output['lowest_ask'])
          ticker.volume    = NumericHelper.to_d(output['base_volume']   )

          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
