module Cryptoexchange::Exchanges
  module Velic
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
          "#{Cryptoexchange::Exchanges::Velic::Market::API_URL}/public/ticker"
        end

        def adapt_all(output)
          output.map do |ticker|
            target      = ticker['base_coin']
            base        = ticker['match_coin']
            market_pair = Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Velic::Market::NAME
            )
            adapt(ticker, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Velic::Market::NAME

          ticker.last      = NumericHelper.to_d(output['recent_price'])
          ticker.high      = NumericHelper.to_d(output['high_price'])
          ticker.low       = NumericHelper.to_d(output['low_price'])
          ticker.volume    = NumericHelper.to_d(output['volume_by_matchcoin_currency'])
          ticker.change    = NumericHelper.to_d(output['price_changed_rate'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
