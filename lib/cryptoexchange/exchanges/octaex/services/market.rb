module Cryptoexchange::Exchanges
  module Octaex
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
          "#{Cryptoexchange::Exchanges::Octaex::Market::API_URL}/all"
        end

        def adapt_all(output)
          output.map do |pair, ticker|
            base, target = pair.split('_')
            market_pair  = Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Octaex::Market::NAME
            )
            adapt(market_pair, ticker)
          end
        end

        def adapt(market_pair, output)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Octaex::Market::NAME
          ticker.last      = NumericHelper.to_d(output['new_price'])
          ticker.ask       = NumericHelper.to_d(output['sell_price'])
          ticker.bid       = NumericHelper.to_d(output['buy_price'])
          ticker.high      = NumericHelper.to_d(output['max_price'])
          ticker.low       = NumericHelper.to_d(output['min_price'])
          ticker.volume    = NumericHelper.to_d(output['amount'])
          ticker.timestamp = Time.now.to_i
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
