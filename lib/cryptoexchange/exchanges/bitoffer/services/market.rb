module Cryptoexchange::Exchanges
  module Bitoffer
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          pairs = JSON.parse(HTTP.get(pairs_url))
          tickers = JSON.parse(HTTP.get(tickers_url))
          output = {}

          pairs["data"].each do |pair|
            ticker = tickers["data"].select {|t| t['instrumentId' ] == pair["instrumentId"]}.first
            output["#{pair["symbol"]}"] = ticker
          end

          adapt_all(output)
        end

        def pairs_url
          "#{Cryptoexchange::Exchanges::Bitoffer::Market::API_URL}/cash/instrument"
        end

        def tickers_url
          "#{Cryptoexchange::Exchanges::Bitoffer::Market::API_URL}/quot/market"
        end

        def adapt_all(output)
          output.map do |pair, ticker|
            base, target = pair.split("-")
            market_pair = Cryptoexchange::Models::MarketPair.new(
                            base: base,
                            target: target,
                            market: Bitoffer::Market::NAME,
                          )
            adapt(market_pair, ticker)
          end
        end

        def adapt(market_pair, output)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Bitoffer::Market::NAME
          ticker.last      = NumericHelper.to_d(output['last'])
          ticker.high      = NumericHelper.to_d(output['high'])
          ticker.low       = NumericHelper.to_d(output['low'])
          ticker.volume    = NumericHelper.to_d(output['volume'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
