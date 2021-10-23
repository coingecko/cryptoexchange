module Cryptoexchange::Exchanges
  module Sistemkoin
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          output = super(ticker_url)
          all_tickers = output.map do |data|
            adapt_all(data)
          end
          tickers_array = []
          all_tickers.each do |tickers|
            tickers.map { |i| tickers_array << i }
          end
          tickers_array
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Sistemkoin::Market::API_URL}/ticker"
        end

        def adapt_all(output)
          tickers = []
          target = output[0]
          output[1].map do |ticker|
            market_pairs = Cryptoexchange::Models::MarketPair.new(
                             base: ticker[1]["symbol"],
                             target: target,
                             market: Sistemkoin::Market::NAME)
              adapt(ticker, market_pairs)
          end
        end

        def adapt(output, market_pair)
          output = output[1]
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Sistemkoin::Market::NAME
          ticker.last      = NumericHelper.to_d(output['current'])
          ticker.bid       = NumericHelper.to_d(output['bidPrice'])
          ticker.ask       = NumericHelper.to_d(output['askPrice'])
          ticker.high      = NumericHelper.to_d(output['high'])
          ticker.low       = NumericHelper.to_d(output['low'])
          ticker.change    = NumericHelper.to_d(output['changeAmount'])
          ticker.volume    = NumericHelper.divide(NumericHelper.to_d(output['volume']), ticker.last)
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
