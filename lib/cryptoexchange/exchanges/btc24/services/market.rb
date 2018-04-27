require 'zlib'

module Cryptoexchange::Exchanges
  module Btc24
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output,market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Btc24::Market::API_URL}/ticker/#{market_pair.base.upcase}#{market_pair.target.upcase}"
        end

        def adapt(output,market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new

          market           = output.first
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Btc24::Market::NAME
          ticker.high      = NumericHelper.to_d(market['DailyBestBuyPrice'])
          ticker.low       = NumericHelper.to_d(market['DailyBestSellPrice'])
          ticker.ask       = NumericHelper.to_d(market['BestAsk'])
          ticker.bid       = NumericHelper.to_d(market['BestBid'])
          ticker.volume    = NumericHelper.to_d(market['DailyTradedTotalVolume'])
          time             = 0
          if market.key?('LastBuyTimestamp')
            if (time < market['LastBuyTimestamp'])
              time         = market['LastBuyTimestamp']
              ticker.last  = market['LastBuyPrice']
            end
          end
          if market.key?('LastSellTimestamp')
            if (time < market['LastSellTimestamp'])
              time         = market['LastSellTimestamp']
              ticker.last  = market['LastSellPrice']
            end
          end
          if time == 0
            time           = Time.now.to_i
          else
            time          /= 1000
          end
          ticker.timestamp = time
          ticker.payload   = output
          ticker
        end

        def http_get(endpoint)
          fetch_response = HTTP.timeout(:write => 2, :connect => 15, :read => 18)
                               .follow.get(endpoint, {
                headers: {
                    "Accept-Encoding" => "gzip"
                }
              }
          )
        end
      end
    end
  end
end
