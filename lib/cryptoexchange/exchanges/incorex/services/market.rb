module Cryptoexchange::Exchanges
  module Incorex
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          output = super ticker_url
          adapt_all output
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Incorex::Market::API_URL}/ticker"
        end

        def adapt_all(output)
          output.map do |market_pair_key, ticker|
            base, target = market_pair_key.split('_')
            market_pair = Cryptoexchange::Models::MarketPair.new(
                base: base,
                target: target,
                market: Incorex::Market::NAME
              )
            adapt(ticker, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Incorex::Market::NAME
          ticker.bid       = NumericHelper.to_d(output[1]) #buy_price
          ticker.ask       = NumericHelper.to_d(output[2]) #sell_price
          ticker.last      = NumericHelper.to_d(output[5]) #last_trade
          ticker.high      = NumericHelper.to_d(output[7]) #high
          ticker.low       = NumericHelper.to_d(output[8]) #low
          ticker.volume    = NumericHelper.to_d(output[6]) #  the total value of all deals within the last 24 hours
          ticker.timestamp = output[9]
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
