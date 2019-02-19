module Cryptoexchange::Exchanges
  module Idax
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
          "#{Cryptoexchange::Exchanges::Idax::Market::API_URL}/ticker"
        end

        def adapt_all(output)
          output['ticker'].map do |output|
            base, target = output['pair'].split('_')
            market_pair = Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              market: Idax::Market::NAME
            )
            adapt(market_pair, output)
          end
        end

        def adapt(market_pair, output)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Idax::Market::NAME

          ticker.last      = NumericHelper.to_d(output['last'])
          ticker.high      = NumericHelper.to_d(output['high'])
          ticker.low       = NumericHelper.to_d(output['low'])
          ticker.volume    = NumericHelper.to_d(output['vol'])

          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
