module Cryptoexchange::Exchanges
  module Neblidex
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
          "#{Cryptoexchange::Exchanges::Neblidex::Market::API_URL}"
        end

        def adapt_all(output)
          output.map do |pair|
            base = pair['tradeAsset']
            target = pair['baseAsset']
            market_pair = Cryptoexchange::Models::MarketPair.new(
                            base: base,
                            target: target,
                            market: Neblidex::Market::NAME
            )
            adapt(market_pair, pair)
          end
        end

        def adapt(market_pair, output)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = Neblidex::Market::NAME
          ticker.last = NumericHelper.to_d(output['lastPrice'])
          ticker.volume = NumericHelper.to_d(output['tradeVolume24Hour'])
          ticker.timestamp = nil
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
