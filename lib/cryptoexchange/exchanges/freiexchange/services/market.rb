module Cryptoexchange::Exchanges
  module Freiexchange
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
          "#{Cryptoexchange::Exchanges::Freiexchange::Market::API_URL}/returnTicker"
        end

        def adapt_all(output)
          output.map do |pair, ticker|
            base, target = pair.split("_")
            market_pair = Cryptoexchange::Models::MarketPair.new(
                            base: base,
                            target: target,
                            market: Freiexchange::Market::NAME
                          )
            adapt(market_pair, ticker)
          end
        end

        def adapt(market_pair, output)
          market = output
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = Freiexchange::Market::NAME
          ticker.volume = NumericHelper.to_d(market.first['volume24h'])
          ticker.high = NumericHelper.to_d(market.first['high'])
          ticker.low = NumericHelper.to_d(market.first['low'])
          ticker.last = NumericHelper.to_d(market.first['last'])
          ticker.timestamp = Time.now.to_i
          ticker.payload = market
          ticker
        end
      end
    end
  end
end
