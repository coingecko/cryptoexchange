module Cryptoexchange::Exchanges
  module Bcex
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
          "#{Cryptoexchange::Exchanges::Bcex::Market::API_URL}/rt/getTradeLists"
        end

        def adapt_all(output)
          client = Cryptoexchange::Client.new
          pairs = client.pairs('bcex')

          all_tickers = []
          output["data"]["main"].map do |tickers|
            tickers[1].map do |t|
             all_tickers << t
            end
          end


          all_tickers.map do |ticker|
            market_pair  = Cryptoexchange::Models::MarketPair.new(
              base:   ticker["token"],
              target: ticker["market"],
              market: Bcex::Market::NAME
            )
            adapt(market_pair, ticker)
          end
        end

        def adapt(market_pair, output)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Bcex::Market::NAME
          ticker.last      = NumericHelper.to_d(output["last"])
          ticker.high      = NumericHelper.to_d(output["max_price"])
          ticker.low       = NumericHelper.to_d(output["min_price"])
          ticker.volume    = NumericHelper.to_d(output["amount"])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
