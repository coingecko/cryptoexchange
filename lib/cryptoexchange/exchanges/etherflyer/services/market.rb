module Cryptoexchange::Exchanges
  module Etherflyer
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
          "#{Cryptoexchange::Exchanges::Etherflyer::Market::API_URL}/market/allticker"
        end

        def adapt_all(output)
          output['ticker'].map do |ticker|
            base, target = ticker['symbol'].split('_')
            market_pair  = Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Etherflyer::Market::NAME
            )
            adapt(ticker, market_pair)
          end
        end

        def adapt(output, market_pair)
          if output.empty?
            nil
          else
            ticker           = Cryptoexchange::Models::Ticker.new
            ticker.base      = market_pair.base
            ticker.target    = market_pair.target
            ticker.market    = Etherflyer::Market::NAME
            ticker.ask       = NumericHelper.to_d(output['sell'])
            ticker.bid       = NumericHelper.to_d(output['buy'])
            ticker.last      = NumericHelper.to_d(output['last'])
            ticker.change    = NumericHelper.to_d(output['change'])
            ticker.volume    = NumericHelper.to_d(output['volume'])
            ticker.payload   = output
            ticker
          end
        end
      end
    end
  end
end
