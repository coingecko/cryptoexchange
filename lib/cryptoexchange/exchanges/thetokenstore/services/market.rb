module Cryptoexchange::Exchanges
  module Thetokenstore
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          output = super(ticker_url)
          output.shift
          adapt_all(output)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Thetokenstore::Market::API_URL}/ticker"
        end

        def adapt_all(output)
          output.map do |pair|
            target, base = pair[0].split('_')
            market_pair = Cryptoexchange::Models::MarketPair.new(
                            base: base,
                            target: target,
                            market: Thetokenstore::Market::NAME
                          )
            adapt(market_pair, pair)
          end
        end

        def adapt(market_pair, output)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = Thetokenstore::Market::NAME
          ticker.last = NumericHelper.to_d(output[1]['last'])
          ticker.ask = NumericHelper.to_d(output[1]['ask'])
          ticker.bid = NumericHelper.to_d(output[1]['bid'])
          ticker.volume = NumericHelper.to_d(output[1]['quoteVolume'])
          ticker.timestamp = nil
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
