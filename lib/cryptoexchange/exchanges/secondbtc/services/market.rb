module Cryptoexchange::Exchanges
  module Secondbtc
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          output = super ticker_url
          adapt_all(output)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Secondbtc::Market::API_URL}/tickers"
        end

        def adapt_all(output)
          output.map do |ticker|
            next unless ticker['tradesEnabled'] == true
            base, target = ticker["tradingPairs"].split('_')
            market_pair = Cryptoexchange::Models::MarketPair.new(
                            base:   base,
                            target: target,
                            market: Secondbtc::Market::NAME,
                          )

            adapt(market_pair, ticker)
          end.compact
        end

        def adapt(market_pair, output)
          ticker         = Cryptoexchange::Models::Ticker.new
          ticker.base    = market_pair.base
          ticker.target  = market_pair.target
          ticker.market  = Secondbtc::Market::NAME
          ticker.last    = NumericHelper.to_d(output['LastPrice'])
          ticker.ask     = NumericHelper.to_d(output['lowestAsk'])
          ticker.bid     = NumericHelper.to_d(output['highestBid'])
          ticker.volume  = NumericHelper.to_d(output['quoteVolume24h'])
          ticker.high    = NumericHelper.to_d(output['high24h'])
          ticker.low     = NumericHelper.to_d(output['low24h'])
          ticker.change  = NumericHelper.to_d(output['percentChange'])
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
