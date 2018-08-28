module Cryptoexchange::Exchanges
  module Paribu
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end
  
        def fetch(market_pair)
          output = super(ticker_url)
          adapt(output, market_pair)
        end

        def ticker_url
          "https://www.paribu.com/ticker"
        end

        def adapt(output, market_pair)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = Paribu::Market::NAME
          ticker.ask = NumericHelper.to_d(output.values[0]['lowestAsk'])
          ticker.bid = NumericHelper.to_d(output.values[0]['highestBid'])
          ticker.last = NumericHelper.to_d(output.values[0]['last'])
          ticker.high = NumericHelper.to_d(output.values[0]['high24hr'])
          ticker.low = NumericHelper.to_d(output.values[0]['low24hr'])
          ticker.volume = NumericHelper.to_d(output.values[0]['volume'])
          ticker.timestamp = nil
          ticker.payload = output
          ticker
        end

      end
    end
  end
end
