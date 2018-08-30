module Cryptoexchange::Exchanges
  module Trademn
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(market_pair, output)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Trademn::Market::API_URL}/ticker/#{market_pair.base}"
        end

        def adapt(market_pair, output)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = Trademn::Market::NAME
          ticker.ask = NumericHelper.to_d(output['data']['sell_price'])
          ticker.bid = NumericHelper.to_d(output['data']['buy_price'])
          ticker.last = NumericHelper.to_d(output['data']['last_price'])
          ticker.high = NumericHelper.to_d(output['data']['max_price'])
          ticker.low = NumericHelper.to_d(output['data']['min_price'])
          ticker.volume = NumericHelper.to_d(output['data']['units_traded'])
          ticker.timestamp = nil
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
