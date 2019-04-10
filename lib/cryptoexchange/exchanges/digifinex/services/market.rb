module Cryptoexchange::Exchanges
  module Digifinex
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          output = super ticker_url
          adapt_all(output)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Digifinex::Market::API_URL}/ticker?apiKey=15cad9a55217c4"
        end

        def adapt_all(output)
          output['ticker'].map do |pair, ticker|
            base, target = pair.split('_')
            market_pair = Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Digifinex::Market::NAME
            )
            adapt(ticker, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Digifinex::Market::NAME

          ticker.last      = NumericHelper.to_d(output['last'])
          ticker.high      = NumericHelper.to_d(output['high'])
          ticker.low       = NumericHelper.to_d(output['low'])
          ticker.bid       = NumericHelper.to_d(output['buy'])
          ticker.ask       = NumericHelper.to_d(output['sell'])
          ticker.volume    = NumericHelper.to_d(output['vol'])
          ticker.change    = NumericHelper.to_d(output['change'])

          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
