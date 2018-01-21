module Cryptoexchange::Exchanges
  module Coinrail
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch(market_pair)
          output = super(ticker_url)
          adapt(output, market_pair)
        end

        def ticker_url
          "https://coinrail.co.kr/main/market_info/"
        end

        def adapt(output, market_pair)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = Coinrail::Market::NAME
          ticker.ask = NumericHelper.to_d(output['sell'])
          ticker.bid = NumericHelper.to_d(output['buy'])
          ticker.last = NumericHelper.to_d(output['last'])
          ticker.high = NumericHelper.to_d(output['high'])
          ticker.low = NumericHelper.to_d(output['low'])
          ticker.volume = NumericHelper.to_d(output['vol'])
          ticker.timestamp = output['time'].to_i
          ticker.payload = output
          ticker
        end

      end
    end
  end
end
