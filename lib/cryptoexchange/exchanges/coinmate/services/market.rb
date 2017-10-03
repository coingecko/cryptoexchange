module Cryptoexchange::Exchanges
  module Coinmate
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair.base, market_pair.target)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Coinmate::Market::API_URL}/ticker?currencyPair=#{market_pair.base}_#{market_pair.target}"
        end

        def adapt(output, base, target)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = base
          ticker.target = target
          ticker.market = Coinmate::Market::NAME
          ticker.ask = NumericHelper.to_d(output['data']['ask'])
          ticker.bid = NumericHelper.to_d(output['data']['bid'])
          ticker.last = NumericHelper.to_d(output['data']['last'])
          ticker.high = NumericHelper.to_d(output['data']['high'])
          ticker.low = NumericHelper.to_d(output['data']['low'])
          ticker.volume = NumericHelper.to_d(output['data']['amount'])
          ticker.timestamp = output['data']['timestamp'].to_i
          ticker.payload = output
          ticker
        end

      end
    end
  end
end
