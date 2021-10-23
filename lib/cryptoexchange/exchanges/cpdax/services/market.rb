module Cryptoexchange::Exchanges
  module Cpdax
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
          "#{Cryptoexchange::Exchanges::Cpdax::Market::API_URL}/tickers/detailed"
        end

        def adapt_all(output)
          output.map do |ticker|
            base, target = ticker['currency_pair'].split('-')
            market_pair  = Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Cpdax::Market::NAME
            )
            adapt(market_pair, ticker)
          end
        end

        def adapt(market_pair, output)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Cpdax::Market::NAME
          ticker.last      = NumericHelper.to_d(output['last'])
          ticker.high      = NumericHelper.to_d(output['high'])
          ticker.low       = NumericHelper.to_d(output['low'])
          ticker.bid       = NumericHelper.to_d(output['bid'])
          ticker.ask       = NumericHelper.to_d(output['ask'])
          ticker.volume    = NumericHelper.divide(NumericHelper.to_d(output['volume']), ticker.last)
          ticker.change    = NumericHelper.to_d(output['rate'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
