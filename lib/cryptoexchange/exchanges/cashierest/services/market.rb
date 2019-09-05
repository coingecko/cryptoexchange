module Cryptoexchange::Exchanges
  module Cashierest
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          #because vcr doesn't use BOM
          if ENV["ENV"] = "test"
            output = super(ticker_url)
          else
            #remove BOM from json 
            output = JSON.parse(HTTP.get(ticker_url).to_s.gsub!("\xEF\xBB\xBF".force_encoding("UTF-8"), ''))
          end
          adapt_all(output)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Cashierest::Market::API_URL}/TickerAll"
        end

        def adapt_all(output)
          output["Cashierest"].map do |output, ticker|
            if ticker["isFrozen"] == "0"
              target, base = output.split('_')
              market_pair = Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              market: Cashierest::Market::NAME
                            )
              adapt(market_pair, ticker)
            end
          end
        end

        def adapt(market_pair, ticker_output)
          ticker = Cryptoexchange::Models::Ticker.new

          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Cashierest::Market::NAME

          ticker.last      = NumericHelper.to_d(ticker_output['last'])
          ticker.ask       = NumericHelper.to_d(ticker_output['lowestAsk'])
          ticker.bid       = NumericHelper.to_d(ticker_output['highestBid'])
          ticker.change    = NumericHelper.to_d(ticker_output['percentChange'])
          ticker.high      = NumericHelper.to_d(ticker_output['high24hr'])
          ticker.low       = NumericHelper.to_d(ticker_output['low24hr'])
          ticker.volume    = NumericHelper.to_d(ticker_output['baseVolume'])
          ticker.payload   = ticker_output
          ticker
        end
      end
    end
  end
end
