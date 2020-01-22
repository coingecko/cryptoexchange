module Cryptoexchange::Exchanges
  module Artisturba
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
          "#{Cryptoexchange::Exchanges::Artisturba::Market::API_URL}/tickers"
        end

        def adapt_all(output)
          output["combinations"].map do |pair, ticker|
            adapt(pair, ticker)
          end.compact
        end

        def adapt(pair, output)
          target, base   = pair.split('_')
          ticker         = Cryptoexchange::Models::Ticker.new
          ticker.base    = base
          ticker.target  = target
          ticker.market  = Artisturba::Market::NAME
          ticker.last    = NumericHelper.to_d(output['last'])
          ticker.high    = NumericHelper.to_d(output['high24hr'])
          ticker.low     = NumericHelper.to_d(output['low24hr'])
          ticker.bid     = NumericHelper.to_d(output['highestBid'])
          ticker.ask     = NumericHelper.to_d(output['lowestAsk'])
          ticker.volume  = NumericHelper.to_d(output['base24hrVolume'])
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
