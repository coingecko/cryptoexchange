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
          adapt_all(output['stats']).flatten
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Koinex::Market::API_URL}/ticker"
        end

        def adapt_all(output)
          output.map do |market|
            market[1].map do |ticker|
                market_pair = Cryptoexchange::Models::MarketPair.new(
                                base: ticker[0],
                                target: GetSymbol.get_symbol(market[0]),
                                market: Koinex::Market::NAME
                              )
              adapt(market_pair, ticker[1])
            end
          end
        end

        def adapt(market_pair, output)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = Koinex::Market::NAME
          ticker.ask       = NumericHelper.to_d(output['lowest_ask'])
          ticker.bid       = NumericHelper.to_d(output['highest_bid'])
          ticker.last      = NumericHelper.to_d(output['last_traded_price'])
          ticker.high      = NumericHelper.to_d(output['max_24hrs'])
          ticker.low       = NumericHelper.to_d(output['min_24hrs'])
          ticker.volume    = NumericHelper.to_d(output['vol_24hrs'])
          ticker.timestamp = nil
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
