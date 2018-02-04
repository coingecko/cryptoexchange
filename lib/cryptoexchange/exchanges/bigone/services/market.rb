module Cryptoexchange::Exchanges
  module Bigone
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
          "#{Cryptoexchange::Exchanges::Bigone::Market::API_URL}/markets"
        end

        def adapt_all(output)
          output['data'].map do |pair|
            base = pair['base']
            target = pair['quote']
            market_pair = Cryptoexchange::Models::MarketPair.new(
                            base: base,
                            target: target,
                            market: Bigone::Market::NAME
                          )
            adapt(market_pair, pair['ticker'])
          end
        end

        def adapt(market_pair, output)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = Bigone::Market::NAME
          ticker.last = NumericHelper.to_d(output['price'].to_f)
          ticker.high = NumericHelper.to_d(output['high'].to_f)
          ticker.low = NumericHelper.to_d(output['low'].to_f)
          ticker.volume = NumericHelper.to_d(output['volume'].to_f)
          ticker.timestamp = Time.now.to_i
          ticker.payload = ticker
          ticker
        end
      end
    end
  end
end
