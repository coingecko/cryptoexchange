module Cryptoexchange::Exchanges
  module Dextrade
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Dextrade::Market::API_URL}/pubticker2/#{market_pair.base}#{market_pair.target}"
        end

        def adapt(output, market_pair)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = Dextrade::Market::NAME
          # ticker.ask = NumericHelper.to_d(output['ask'])
          # ticker.bid = NumericHelper.to_d(output['bid'])
          ticker.last = NumericHelper.to_d(output['last_price'])
          ticker.high = NumericHelper.to_d(output['high'])
          ticker.low = NumericHelper.to_d(output['low'])
          ticker.volume = NumericHelper.to_d(output['volume'])
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
