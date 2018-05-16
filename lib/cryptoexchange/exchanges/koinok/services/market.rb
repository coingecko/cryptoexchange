module Cryptoexchange::Exchanges
  module Koinok
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
          "#{Cryptoexchange::Exchanges::Koinok::Market::API_URL}/ticker"
        end

        def adapt_all(output)
          output['result'].map do |output|
            base, target = output['marketSymbol'].split("-")
            market_pair = Cryptoexchange::Models::MarketPair.new(
                            base: base,
                            target: target,
                            market: Koinok::Market::NAME
                            )
            adapt(market_pair, output)
          end
        end

        def adapt(market_pair, output)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = Koinok::Market::NAME

          ticker.high = NumericHelper.to_d(output['high24'])
          ticker.low = NumericHelper.to_d(output['low24'])
          ticker.last = NumericHelper.to_d(output['price'])
          ticker.volume = NumericHelper.to_d(output['volume'])
          ticker.bid = NumericHelper.to_d(output['highestBid'])
          ticker.ask = NumericHelper.to_d(output['lowestAsk'])

          ticker.timestamp = Time.now.to_i
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
