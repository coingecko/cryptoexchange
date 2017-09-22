module Cryptoexchange::Exchanges
  module Luno
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
          "#{Cryptoexchange::Exchanges::Luno::Market::API_URL}/tickers"
        end

        def adapt_all(output)
          output['tickers'].map do |ticker|
            base = ticker['pair'][0..2]
            target = ticker['pair'][3..5]
            market_pair = Cryptoexchange::Models::MarketPair.new(
                            base: base,
                            target: target,
                            market: Luno::Market::NAME
                          )
            adapt(ticker, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Luno::Market::NAME
          ticker.ask       = NumericHelper.to_d(output['ask'])
          ticker.bid       = NumericHelper.to_d(output['bid'])
          ticker.last      = NumericHelper.to_d(output['last_trade'])
          ticker.volume    = NumericHelper.to_d(output['rolling_24_hour_volume'])
          ticker.timestamp = output['timestamp'].to_i / 1000
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
