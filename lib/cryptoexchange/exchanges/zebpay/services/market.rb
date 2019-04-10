module Cryptoexchange::Exchanges
  module Zebpay
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
          "#{Cryptoexchange::Exchanges::Zebpay::Market::API_URL}/market"
        end

        def adapt_all(output)
          output.map do |output|
            base, target = output['pair'].split('-')
            market_pair = Cryptoexchange::Models::MarketPair.new(
                            base: base,
                            target: target,
                            market: Zebpay::Market::NAME
                            )
            adapt(output, market_pair)
          end
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
          ticker.timestamp = nil
          ticker.payload = output
          ticker
        end

      end
    end
  end
end
