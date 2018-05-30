module Cryptoexchange::Exchanges
  module Jubi
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
          "#{Cryptoexchange::Exchanges::Jubi::Market::API_URL}/allticker"
        end

        def adapt_all(output)
          default_target = 'CNY'
          output.map do |base, ticker|
            market_pair = Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: default_target,
              market: Jubi::Market::NAME
            )

            adapt(ticker, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Jubi::Market::NAME
          ticker.last      = NumericHelper.to_d(output['last'])
          ticker.bid       = NumericHelper.to_d(output['buy'])
          ticker.ask       = NumericHelper.to_d(output['sell'])
          ticker.high      = NumericHelper.to_d(output['high'])
          ticker.low       = NumericHelper.to_d(output['low'])
          ticker.volume    = NumericHelper.to_d(output['vol'])
          ticker.timestamp = DateTime.now.to_time.to_i
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
