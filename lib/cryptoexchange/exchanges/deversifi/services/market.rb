module Cryptoexchange::Exchanges
  module Deversifi
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
          "#{Cryptoexchange::Exchanges::Deversifi::Market::API_URL}/tickers?symbols=ALL"
        end

        def adapt_all(output)
          output.map do |ticker|
            pair = ticker[0]

            next if pair[0] != 't'

            if pair.include? ":"
              base, target = pair.split(":")
            else
              base = pair[1..pair.length - 4]
              target = pair[-3..-1]
            end

            market_pair = Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Deversifi::Market::NAME
            )

            adapt(market_pair, ticker)
          end.compact
        end

        def adapt(market_pair, output)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = Deversifi::Market::NAME

          # [
          #   SYMBOL,
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

          ticker.ask = NumericHelper.to_d(output[3])
          ticker.bid = NumericHelper.to_d(output[1])
          ticker.last = NumericHelper.to_d(output[7])
          ticker.high = NumericHelper.to_d(output[9])
          ticker.low = NumericHelper.to_d(output[10])
          ticker.volume = NumericHelper.to_d(output[8])
          ticker.timestamp = nil
          ticker.payload = output
          ticker
        end
      end
    end
  end
end