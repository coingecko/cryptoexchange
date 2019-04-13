module Cryptoexchange::Exchanges
  module Bigmarkets
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
          "#{Cryptoexchange::Exchanges::Bigmarkets::Market::API_URL}/tickers"
        end

        def adapt_all(output)
          output['combinations'].map do |pair|
            base, target = pair['pair'].split('_')
            market_pair  = Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Bigmarkets::Market::NAME
            )
            adapt(market_pair, pair)
          end
        end

        def adapt(market_pair, output)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Bigmarkets::Market::NAME
          ticker.last      = NumericHelper.to_d(output['last'])
          ticker.high      = NumericHelper.to_d(output['highsale'])
          ticker.low       = NumericHelper.to_d(output['lowsale'])
          ticker.volume    = NumericHelper.to_d(output['baseVolume']) / ticker.last
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
