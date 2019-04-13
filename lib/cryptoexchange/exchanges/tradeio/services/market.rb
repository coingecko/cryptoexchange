module Cryptoexchange::Exchanges
  module Tradeio
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
          "#{Cryptoexchange::Exchanges::Tradeio::Market::API_URL}/marketdata-ws/24hr"
        end

        def adapt_all(output)
          output.map do |pair|
            base, target = pair['instrument'].split('_')
            market_pair = Cryptoexchange::Models::MarketPair.new(
                            base: base.upcase,
                            target: target.upcase,
                            market: Tradeio::Market::NAME
                          )
            adapt(market_pair, pair)
          end
        end

        def adapt(market_pair, output)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = Tradeio::Market::NAME
          ticker.last = NumericHelper.to_d(output['close'])
          ticker.high = NumericHelper.to_d(output['high'])
          ticker.low = NumericHelper.to_d(output['low'])
          ticker.volume = NumericHelper.to_d(output['volume'])
          ticker.timestamp = DateTime.parse(output['end']).to_time.to_i
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
