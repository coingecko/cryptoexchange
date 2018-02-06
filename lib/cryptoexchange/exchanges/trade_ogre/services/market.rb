module Cryptoexchange::Exchanges
  module TradeOgre
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
          "#{Cryptoexchange::Exchanges::TradeOgre::Market::API_URL}/markets"
        end

        def adapt_all(output)
          output.map do |market|
            target, base = market.keys.first.split('-')
            market_pair = Cryptoexchange::Models::MarketPair.new(
                            base: base,
                            target: target,
                            market: TradeOgre::Market::NAME
                          )
            adapt(market.values.first, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = TradeOgre::Market::NAME
          ticker.last = NumericHelper.to_d(output['initialprice'])
          ticker.high = NumericHelper.to_d(output['high'])
          ticker.low = NumericHelper.to_d(output['low'])
          ticker.volume = NumericHelper.divide(NumericHelper.to_d(output['volume']), ticker.last)
          ticker.timestamp = Time.now.to_i
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
