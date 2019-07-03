module Cryptoexchange::Exchanges
  module NewCapital
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
          "#{Cryptoexchange::Exchanges::NewCapital::Market::API_URL}/ticker"
        end

        def adapt_all(output)
          output.map do |pair|
            base, target = pair["symbol"].split('_')
            market_pair = Cryptoexchange::Models::MarketPair.new(
                base: base,
                target: target,
                market: NewCapital::Market::NAME
            )
            adapt(market_pair, pair)
          end
        end

        def adapt(market_pair, output)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = NewCapital::Market::NAME
          ticker.last = NumericHelper.to_d(output['lastPrice'])
          ticker.bid = NumericHelper.to_d(output['bidPrice'])
          ticker.ask = NumericHelper.to_d(output['askPrice'])
          ticker.high = NumericHelper.to_d(output['highPrice'])
          ticker.low = NumericHelper.to_d(output['lowPrice'])
          ticker.volume = NumericHelper.to_d(output['volume'])
          ticker.change = NumericHelper.to_d(output['priceChangePercent'])
          ticker.timestamp = nil
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
