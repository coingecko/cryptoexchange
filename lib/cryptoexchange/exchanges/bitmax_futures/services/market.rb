module Cryptoexchange::Exchanges
  module BitmaxFutures
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super ticker_url(market_pair)
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::BitmaxFutures::Market::API_URL}/ticker?symbol=#{market_pair.inst_id}"
        end

        def adapt(output, market_pair)
          ticker                   = Cryptoexchange::Models::Ticker.new
          ticker.base              = market_pair.base
          ticker.target            = market_pair.target
          ticker.contract_interval = market_pair.contract_interval
          ticker.inst_id           = market_pair.inst_id
          ticker.market            = BitmaxFutures::Market::NAME

          ticker.bid               = NumericHelper.to_d(output['data']['bid'][0])
          ticker.ask               = NumericHelper.to_d(output['data']['ask'][0])
          ticker.last              = NumericHelper.to_d(output['data']['close'])
          ticker.volume            = NumericHelper.to_d(output['data']['volume'])
          ticker.high              = NumericHelper.to_d(output['data']['high'])
          ticker.low               = NumericHelper.to_d(output['data']['low'])
          ticker.timestamp         = nil
          ticker.payload           = output
          ticker
        end
      end
    end
  end
end
