module Cryptoexchange::Exchanges
  module Allcoin
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          params = { symbol: "#{market_pair.base.downcase}2#{market_pair.target.downcase}"}
          response = HTTP.timeout(:write => 4, :connect => 8, :read => 15).post(ticker_url, :form => params)
          output = JSON.parse(response)
          adapt(output, market_pair)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Allcoin::Market::API_URL}/Api_Order/ticker"
        end

        def adapt(output, market_pair)
          ticker = Cryptoexchange::Models::Ticker.new
          base = market_pair.base
          target = market_pair.target

          ticker.base      = base
          ticker.target    = target
          ticker.market    = Allcoin::Market::NAME
          ticker.ask       = NumericHelper.to_d(output['data']['sell'])
          ticker.bid       = NumericHelper.to_d(output['data']['buy'])
          ticker.last      = NumericHelper.to_d(output['data']['last'])
          ticker.high      = NumericHelper.to_d(output['data']['high'])
          ticker.low       = NumericHelper.to_d(output['data']['low'])
          ticker.volume    = NumericHelper.to_d(output['data']['vol'])
          ticker.timestamp = Time.now.to_i
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
