module Cryptoexchange::Exchanges
  module Rfinex
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
          "#{Cryptoexchange::Exchanges::Rfinex::Market::API_URL}/tickers.json"
        end

        def adapt_all(output)
          output['body'].map do |pair|
            symbol = pair['name'].upcase
            base, target = symbol.split(/(CNYR$)+(.*)|(ETH$)+(.*)|(USDT$)+(.*)/)
            market_pair  = Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Rfinex::Market::NAME
            )
            adapt(market_pair, pair)
          end
        end

        def adapt(market_pair, output)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Rfinex::Market::NAME
          ticker.last      = NumericHelper.to_d(output['ticker']['close'].to_f)
          ticker.high      = NumericHelper.to_d(output['ticker']['high'].to_f)
          ticker.low       = NumericHelper.to_d(output['ticker']['low'].to_f)
          ticker.bid       = NumericHelper.to_d(output['ticker']['buy'].to_f)
          ticker.ask       = NumericHelper.to_d(output['ticker']['sell'].to_f)
          ticker.volume    = NumericHelper.to_d(output['ticker']['vol'].to_f)
          ticker.timestamp = output['at']
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
