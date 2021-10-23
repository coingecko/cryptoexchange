module Cryptoexchange::Exchanges
  module Vb
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Vb::Market::API_URL}/ticker?symbol=#{market_pair.inst_id}"
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.inst_id   = market_pair.inst_id
          ticker.market    = Vb::Market::NAME
          ticker.ask       = NumericHelper.to_d(output['data']['sell'])
          ticker.bid       = NumericHelper.to_d(output['data']['buy'])
          ticker.last      = NumericHelper.to_d(output['data']['last'])
          ticker.high      = NumericHelper.to_d(output['data']['high'])
          ticker.low       = NumericHelper.to_d(output['data']['low'])
          ticker.volume    = NumericHelper.to_d(output['data']['vol'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
