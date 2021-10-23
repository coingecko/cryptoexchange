module Cryptoexchange::Exchanges
  module HuobiId
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
          "#{Cryptoexchange::Exchanges::HuobiId::Market::API_URL}/market/tickers"
        end

        def adapt_all(output)
          output['data'].map do |pair|
            base, target = HuobiId::Market.separate_symbol(pair["symbol"])
            market_pair = Cryptoexchange::Models::MarketPair.new({
                            base: base,
                            target: target,
                            market: HuobiId::Market::NAME
                          })

            adapt(market_pair, pair)
          end
        end

        def adapt(market_pair, output)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = HuobiId::Market::NAME
          ticker.last = NumericHelper.to_d(output['close'])
          ticker.high = NumericHelper.to_d(output['high'])
          ticker.low = NumericHelper.to_d(output['low'])
          ticker.volume = NumericHelper.to_d(output['amount'])
          ticker.timestamp = nil
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
