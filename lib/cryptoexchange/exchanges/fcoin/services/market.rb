module Cryptoexchange::Exchanges
  module Fcoin
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output['data'], market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Fcoin::Market::API_URL}/market/ticker/#{market_pair.base.downcase}#{market_pair.target.downcase}"
        end

        def adapt(output, market_pair)
          #  [   0 "Latest Transacted Price",
          #      1 "The volume of the last transaction",
          #      2 "The biggest buy one price",
          #      3 "Best Buy One",
          #      4 "Minimum selling price",
          #      5 "Minimum to sell a quantity",
          #      6 "The trading price 24 hours ago",
          #      7 "Highest price within 24 hours",
          #      8 "Lowest price within 24 hours",
          #      9 "Base currency volume in 24 hours, such as btc volume in btcusdt",
          #      10 "Currency trading volume in 24 hours, such as the amount of usdt in btcusdt"   ]

          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Fcoin::Market::NAME
          ticker.ask       = NumericHelper.to_d(output['ticker'][4])
          ticker.bid       = NumericHelper.to_d(output['ticker'][2])
          ticker.last      = NumericHelper.to_d(output['ticker'][0])
          ticker.high      = NumericHelper.to_d(output['ticker'][7])
          ticker.low       = NumericHelper.to_d(output['ticker'][8])
          ticker.volume    = NumericHelper.to_d(output['ticker'][9])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
