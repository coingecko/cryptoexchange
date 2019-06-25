module Cryptoexchange::Exchanges
  module Yobit
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(self.ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          parameter = "#{market_pair.base.downcase}_#{market_pair.target.downcase}"
          "#{Cryptoexchange::Exchanges::Yobit::Market::API_URL}/ticker/#{parameter}"
        end

        def adapt(output, market_pair)
          data = output["#{market_pair.base.downcase}_#{market_pair.target.downcase}"]
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Yobit::Market::NAME
          ticker.last      = NumericHelper.to_d(data['last'])
          ticker.bid       = NumericHelper.to_d(data['buy'])
          ticker.ask       = NumericHelper.to_d(data['sell'])
          ticker.high      = NumericHelper.to_d(data['high'])
          ticker.low       = NumericHelper.to_d(data['low'])
          ticker.volume    = NumericHelper.to_d(data['vol_cur'])
          ticker.timestamp = nil
          ticker.payload   = data
          ticker
        end
      end
    end
  end
end
