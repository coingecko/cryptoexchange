module Cryptoexchange::Exchanges
  module Bione
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
          "#{Cryptoexchange::Exchanges::Bione::Market::API_URL}/tickers"
        end

        def adapt_all(output)
          output['data'].map do |pair|
            base, target = pair['symbol'].split('_')
            market_pair = Cryptoexchange::Models::MarketPair.new(
                            base: base.upcase,
                            target: target.upcase,
                            market: Bione::Market::NAME
                          )
            adapt(market_pair, pair)
          end
        end

        def adapt(market_pair, pair)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = Bione::Market::NAME
          ticker.last = NumericHelper.to_d(pair['last'])
          ticker.bid = NumericHelper.to_d(pair['buy'])
          ticker.ask = NumericHelper.to_d(pair['sell'])
          ticker.high = NumericHelper.to_d(pair['high'])
          ticker.low = NumericHelper.to_d(pair['low'])
          ticker.change = NumericHelper.to_d(pair['change'])
          ticker.volume = NumericHelper.to_d(pair['vol'])
          ticker.timestamp = nil
          ticker.payload = pair
          ticker
        end
      end
    end
  end
end
