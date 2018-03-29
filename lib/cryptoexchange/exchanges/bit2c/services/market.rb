module Cryptoexchange::Exchanges
  module Bit2c
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
          "#{Cryptoexchange::Exchanges::Bit2c::Market::API_URL}/Exchanges/#{market_pair.base}#{market_pair.target}/Ticker.json"
        end

        def adapt(output, market_pair)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = Bit2c::Market::NAME
          ticker.ask = NumericHelper.to_d(output['l'])
          ticker.bid = NumericHelper.to_d(output['h'])
          ticker.last = NumericHelper.to_d(output['ll'])
          ticker.volume = NumericHelper.to_d(output['a'])
          ticker.timestamp = Time.now.to_i
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
