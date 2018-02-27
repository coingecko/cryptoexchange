module Cryptoexchange::Exchanges
  module Koinex
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
          "#{Cryptoexchange::Exchanges::Koinex::Market::API_URL}/ticker"
        end

        def adapt_all(output)
          output["stats"].map do |pair, tickers|
            base = pair
            target = "INR"
            market_pair = Cryptoexchange::Models::MarketPair.new(
                            base: base,
                            target: target,
                            market: Koinex::Market::NAME
                          )
            adapt(market_pair, tickers, [pair, tickers])
          end
        end

        def adapt(market_pair, tickers, output)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = Koinex::Market::NAME
          ticker.last = NumericHelper.to_d(tickers['last_traded_price'].to_f)
          ticker.bid = NumericHelper.to_d(tickers['highest_bid'].to_f)
          ticker.ask = NumericHelper.to_d(tickers['lowest_ask'].to_f)
          ticker.volume = NumericHelper.to_d(tickers['vol_24hrs'].to_f)
          ticker.timestamp = Time.now.to_i
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
