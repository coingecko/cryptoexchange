module Cryptoexchange::Exchanges
  module BitsharesAssets
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
          "#{Cryptoexchange::Exchanges::BitsharesAssets::Market::API_URL}/asset/markets?asset=BTS"
        end

        def adapt_all(output)
          output.map do |output|
            base = output[0]
            target = "BTS"
            market_pair = Cryptoexchange::Models::MarketPair.new(
                            base: base,
                            target: target,
                            market: BitsharesAssets::Market::NAME
                          )
            adapt(market_pair, output)
          end
        end

        def adapt(market_pair, output)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = BitsharesAssets::Market::NAME

          ticker.last      = NumericHelper.divide(1.0, NumericHelper.to_d(output[1]['price']))
          ticker.volume    = NumericHelper.to_d(output[1]['volume24'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
