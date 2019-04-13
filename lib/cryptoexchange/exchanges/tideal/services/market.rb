module Cryptoexchange::Exchanges
  module Tideal
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
          "#{Cryptoexchange::Exchanges::Tideal::Market::API_URL}/tickers"
        end

        def adapt_all(output)
          output.map do |pair|
            base, target = pair[0].split(/(btc$)+(.*)|(eth$)+(.*)|(usx$)+(.*)/)
            next unless base && target
            market_pair  = Cryptoexchange::Models::MarketPair.new(
              base:   base.upcase,
              target: target.upcase,
              market: Tideal::Market::NAME
            )
            adapt(market_pair, pair[1])
          end
        end

        def adapt(market_pair, output)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Tideal::Market::NAME
          ticker.last      = NumericHelper.to_d(output['ticker']['last'])
          ticker.high      = NumericHelper.to_d(output['ticker']['high'])
          ticker.low       = NumericHelper.to_d(output['ticker']['low'])
          ticker.bid       = NumericHelper.to_d(output['ticker']['buy'])
          ticker.ask       = NumericHelper.to_d(output['ticker']['sell'])
          ticker.volume    = NumericHelper.to_d(output['ticker']['vol'])
          ticker.timestamp = output['at']
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
