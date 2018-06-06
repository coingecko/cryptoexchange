module Cryptoexchange::Exchanges
  module Topbtc
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
          "#{Cryptoexchange::Exchanges::Topbtc::Market::API_URL}"
        end

        def adapt_all(output)
          output.map do |pair|
            base = pair['coin']
            target = pair['market']
            market_pair = Cryptoexchange::Models::MarketPair.new(
                            base: base,
                            target: target,
                            market: Topbtc::Market::NAME
            )
            adapt(market_pair, pair)
          end
        end

        def adapt(market_pair, output)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = Topbtc::Market::NAME

          ticker.last = NumericHelper.to_d(output['ticker']['last'])
          ticker.ask = NumericHelper.to_d(output['ticker']['sell'])
          ticker.bid = NumericHelper.to_d(output['ticker']['buy'])
          ticker.volume = NumericHelper.to_d(output['ticker']['vol'])
          ticker.high = NumericHelper.to_d(output['ticker']['high'])
          ticker.low = NumericHelper.to_d(output['ticker']['low'])

          ticker.timestamp = Time.now.to_i
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
