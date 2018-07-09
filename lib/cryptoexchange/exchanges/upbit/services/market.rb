module Cryptoexchange::Exchanges
  module Upbit
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
          "#{Cryptoexchange::Exchanges::Upbit::Market::API_URL}/ticker?markets=#{market_pair.target}-#{market_pair.base}"
        end

        def adapt(output, market_pair)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = Upbit::Market::NAME
          ticker.last = NumericHelper.to_d(output[0]['trade_price'])
          ticker.high = NumericHelper.to_d(output[0]['high_price'])
          ticker.low = NumericHelper.to_d(output[0]['low_price'])
          ticker.volume = NumericHelper.to_d(output[0]['acc_trade_volume_24h'])
          ticker.timestamp = Time.now.to_i
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
