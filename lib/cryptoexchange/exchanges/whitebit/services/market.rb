module Cryptoexchange::Exchanges
  module Whitebit
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
          "#{Cryptoexchange::Exchanges::Whitebit::Market::API_URL}/tickers"
        end

        def adapt_all(output)
          output.map do |pair|
            symbol = pair[0].upcase
            base, target = symbol.split(/(BTC$)+(.*)|(ETH$)+(.*)|(USD$)+(.*)/)
            next unless base && target
            market_pair = Cryptoexchange::Models::MarketPair.new(
                            base: base.upcase,
                            target: target.upcase,
                            market: Whitebit::Market::NAME
                          )
            adapt(market_pair, pair[1])
          end
        end

        def adapt(market_pair, output)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = Whitebit::Market::NAME
          ticker.last = NumericHelper.to_d(output['ticker']['last'])
          ticker.bid = NumericHelper.to_d(output['ticker']['buy'])
          ticker.ask = NumericHelper.to_d(output['ticker']['sell'])
          ticker.high = NumericHelper.to_d(output['ticker']['high'])
          ticker.low = NumericHelper.to_d(output['ticker']['low'])
          ticker.volume = NumericHelper.to_d(output['ticker']['vol'])
          ticker.timestamp = output['at']
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
