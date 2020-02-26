module Cryptoexchange::Exchanges
  module Beaxy
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
          "#{Cryptoexchange::Exchanges::Beaxy::Market::API_URL}/symbols/#{market_pair.base.upcase}#{market_pair.target.upcase}/rate"
        end

        def adapt(output, market_pair)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = Beaxy::Market::NAME
          ticker.last = NumericHelper.to_d(output['price'])
          ticker.high = NumericHelper.to_d(output['high24'])
          ticker.low = NumericHelper.to_d(output['low24'])
          ticker.volume = NumericHelper.to_d(output['volume24'])
          ticker.change = NumericHelper.to_d(output['change24'])
          ticker.ask = NumericHelper.to_d(output['ask'])
          ticker.bid = NumericHelper.to_d(output['bid'])
          ticker.timestamp = nil
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
