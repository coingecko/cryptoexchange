module Cryptoexchange::Exchanges
  module Cybex
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          base   = market_pair.base
          target = market_pair.target
          output = fetch_using_post(ticker_url, { "jsonrpc": "2.0", "method": "get_ticker", "params": ["#{target}", "#{base}"], "id": 1 })
          adapt(output)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Cybex::Market::API_URL}"
        end

        def adapt(output)
          data         = output['result']
          base = data['quote']
          target = data['base']

          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = base
          ticker.target    = target
          ticker.market    = Cybex::Market::NAME
          ticker.last      = NumericHelper.to_d(data['latest'])
          ticker.bid       = NumericHelper.to_d(data['highest_bid'])
          ticker.ask       = NumericHelper.to_d(data['lowest_ask'])
          ticker.volume    = NumericHelper.to_d(data['quote_volume'])
          ticker.change    = NumericHelper.to_d(data['percent_change'])
          ticker.timestamp = Time.now.to_i
          ticker.payload   = data
          ticker
        end
      end
    end
  end
end
