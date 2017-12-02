module Cryptoexchange::Exchanges
  module Kucoin
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
          "#{Cryptoexchange::Exchanges::Kucoin::Market::API_URL}/open/tick"
        end

        def adapt_all(output)
          output['data'].map do |ticker|
            base, target = ticker['symbol'].split('-')
            market_pair = Cryptoexchange::Models::MarketPair.new(
                            base: base,
                            target: target,
                            market: Kucoin::Market::NAME
                          )
            adapt(ticker, market_pair)
          end
        end

        def adapt(output, market_pair)
          market = output
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = Kucoin::Market::NAME
          ticker.ask = NumericHelper.to_d(market['sell'])
          ticker.bid = NumericHelper.to_d(market['buy'])
          ticker.last = NumericHelper.to_d(market['lastDealPrice'])
          ticker.high = NumericHelper.to_d(market['high'])
          ticker.low = NumericHelper.to_d(market['low'])
          ticker.volume = NumericHelper.to_d(market['vol'])
          ticker.timestamp = market['datetime'].to_i / 1000
          ticker.payload = market
          ticker
        end
      end
    end
  end
end
