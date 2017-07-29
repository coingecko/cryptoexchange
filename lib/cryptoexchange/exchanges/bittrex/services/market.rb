module Cryptoexchange::Exchanges
  module Bittrex
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output)
        end

        def ticker_url(market_pair)
          base = market_pair.base
          target = market_pair.target
          "#{Cryptoexchange::Exchanges::Bittrex::Market::API_URL}/public/getmarketsummary?market=#{base}-#{target}"
        end

        def adapt(output)
          ticker = Cryptoexchange::Models::Ticker.new
          market = output['result'][0]

          ticker.base      = market['MarketName'].split("-")[0]
          ticker.target    = market['MarketName'].split("-")[1]
          ticker.market    = Bittrex::Market::NAME
          ticker.last      = NumericHelper.to_d(market['Last'])
          ticker.high      = NumericHelper.to_d(market['High'])
          ticker.low       = NumericHelper.to_d(market['Low'])
          ticker.ask       = NumericHelper.to_d(market['Ask'])
          ticker.bid       = NumericHelper.to_d(market['Bid'])
          ticker.volume    = NumericHelper.to_d(market['BaseVolume'])
          ticker.timestamp = DateTime.now.to_time.to_i
          ticker.payload   = market
          ticker
        end
      end
    end
  end
end
