module Cryptoexchange::Exchanges
  module Acx
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          output = super ticker_url
          adapt_all output
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Acx::Market::API_URL}/tickers"
        end

        def adapt_all(output)
          output.map do |market_pair_key, ticker|
            base, target = ticker["name"].split('/')
            market_pair = Cryptoexchange::Models::MarketPair.new(
                base: base,
                target: target,
                market: Acx::Market::NAME
              )
            adapt(ticker, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Acx::Market::NAME
          ticker.ask       = NumericHelper.to_d(output['ticker']['sell'])
          ticker.bid       = NumericHelper.to_d(output['ticker']['buy'])
          ticker.last      = NumericHelper.to_d(output['ticker']['last'])
          ticker.high      = NumericHelper.to_d(output['ticker']['high'])
          ticker.low       = NumericHelper.to_d(output['ticker']['low'])
          ticker.change    = ticker.last - NumericHelper.to_d(output['ticker']['open'])
          ticker.volume    = NumericHelper.to_d(output['ticker']['vol'])
          ticker.timestamp = output['at']
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
