  module Cryptoexchange::Exchanges
  module Ethfinex
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
          "#{Cryptoexchange::Exchanges::Ethfinex::Market::API_URL}/v2/ticker/t#{market_pair.base.upcase}#{market_pair.target.upcase}"
        end

        def adapt(output, market_pair)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = Ethfinex::Market::NAME

          # [
          #   BID,
          #   BID_SIZE,
          #   ASK,
          #   ASK_SIZE,
          #   DAILY_CHANGE,
          #   DAILY_CHANGE_PERC,
          #   LAST_PRICE,
          #   VOLUME,
          #   HIGH,
          #   LOW
          # ]

          ticker.ask = NumericHelper.to_d(output[2])
          ticker.bid = NumericHelper.to_d(output[0])
          ticker.last = NumericHelper.to_d(output[-4])
          ticker.high = NumericHelper.to_d(output[-2])
          ticker.low = NumericHelper.to_d(output[-1])
          ticker.volume = NumericHelper.to_d(output[-3])
          ticker.timestamp = nil
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
