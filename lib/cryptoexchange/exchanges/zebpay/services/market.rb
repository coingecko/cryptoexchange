module Cryptoexchange::Exchanges
  module Zebpay
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
          "#{Cryptoexchange::Exchanges::Zebpay::Market::API_URL}/market/ticker-new/#{market_pair.base}/#{market_pair.target}"
        end

        def adapt(output, market_pair)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = Zebpay::Market::NAME
          ticker.ask = NumericHelper.to_d(output["sell"])
          ticker.bid = NumericHelper.to_d(output["buy"])
          ticker.last = NumericHelper.to_d(output["market"])
          ticker.high = NumericHelper.to_d(output["24hoursHigh"])
          ticker.low = NumericHelper.to_d(output["24hoursLow"])
          ticker.volume = NumericHelper.to_d(output["volume"])
          ticker.timestamp = Time.now.to_i
          ticker.payload = output
          ticker
        end

      end
    end
  end
end
